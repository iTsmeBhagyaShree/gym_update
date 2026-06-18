import React, { useState, useEffect } from "react";
import axiosInstance from "../../Api/axiosInstance";
import { FaCrown, FaCheck, FaCalendarAlt, FaTimes } from "react-icons/fa";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

const AdminMySubscription = () => {
  const [plans, setPlans] = useState([]);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [selectedPlanId, setSelectedPlanId] = useState(null);
  const [billingDuration, setBillingDuration] = useState("Yearly");
  const [amount, setAmount] = useState("");
  
  const [user, setUser] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [requestHistory, setRequestHistory] = useState([]);
  const [loadingHistory, setLoadingHistory] = useState(true);

  useEffect(() => {
    // Get logged-in user info
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      const parsedUser = JSON.parse(storedUser);
      setUser(parsedUser);
      fetchRequestHistory(parsedUser.email);
    }
    fetchPlans();
  }, []);

  const fetchRequestHistory = async (email) => {
    if (!email) return;
    try {
      setLoadingHistory(true);
      const res = await axiosInstance.get(`/purchases?email=${email}`);
      if (res.data.success && Array.isArray(res.data.data)) {
        setRequestHistory(res.data.data);
      }
    } catch (err) {
      console.error("Failed to load request history:", err);
    } finally {
      setLoadingHistory(false);
    }
  };

  const fetchPlans = async () => {
    try {
      setLoading(true);
      const res = await axiosInstance.get("/plans");
      if (res.data.success) {
        // Filter only ACTIVE plans
        const activePlans = res.data.plans.filter(p => p.status === "ACTIVE");
        setPlans(activePlans);
        if (activePlans.length > 0) {
          setSelectedPlanId(activePlans[0].id);
          setAmount(activePlans[0].price); // Default to plan price
        }
      }
    } catch (err) {
      console.error("Failed to load plans:", err);
      toast.error("Failed to load available plans.");
    } finally {
      setLoading(false);
    }
  };

  const handlePlanSelect = (plan) => {
    setSelectedPlanId(plan.id);
    setAmount(plan.price);
  };

  const openConfirmation = () => {
    if (!selectedPlanId) {
      toast.warn("Please select a plan first.");
      return;
    }
    if (!amount || Number(amount) <= 0) {
      toast.warn("Please enter a valid amount.");
      return;
    }
    if (!user) {
      toast.error("User information not found. Please log in again.");
      return;
    }
    setShowModal(true);
  };

  const handleSubmitRequest = async () => {
    const selectedPlanData = plans.find(p => p.id === selectedPlanId);
    if (!selectedPlanData) return;

    setSubmitting(true);
    try {
      const payload = {
        selectedPlan: selectedPlanData.name,
        companyName: user.fullName || "Gym Owner", // Fallback to fullName since companyName might not exist in token
        email: user.email || "",
        phone: user.phone || "",
        adminName: user.fullName || "",
        branchName: user.branchName || "",
        billingDuration: billingDuration,
        amount: Number(amount),
        startDate: new Date().toISOString()
      };

      const response = await axiosInstance.post("/purchases", payload);
      if (response.data && response.data.success) {
        toast.success("Plan request submitted successfully! Super Admin will review it shortly.");
        setShowModal(false);
        fetchRequestHistory(user.email); // Refresh history
      } else {
        toast.error("Failed to submit request.");
      }
    } catch (error) {
      console.error("Error submitting purchase:", error);
      toast.error(error.response?.data?.message || "Failed to submit plan request.");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="container-fluid py-4" style={{ backgroundColor: "#f4f7f6", minHeight: "100vh" }}>
      <ToastContainer position="top-right" autoClose={3000} />
      
      <div className="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h3 className="fw-bold mb-1" style={{ color: "#2c3e50" }}>My Subscription</h3>
          <p className="text-muted mb-0">Manage your gym software subscription and request upgrades.</p>
        </div>
      </div>

      {/* Request History Section */}
      <div className="card shadow-sm border-0 rounded-4 mb-5">
        <div className="card-header bg-white border-bottom-0 pt-4 pb-2 px-4">
          <h5 className="fw-bold text-dark mb-0">My Request History</h5>
        </div>
        <div className="card-body p-0 px-2 pb-3">
          {loadingHistory ? (
            <div className="text-center py-4">
              <div className="spinner-border text-primary spinner-border-sm" role="status"></div>
            </div>
          ) : requestHistory.length === 0 ? (
            <div className="text-center py-4 text-muted small">No past requests found.</div>
          ) : (
            <div className="table-responsive px-3">
              <table className="table table-hover table-borderless align-middle mb-0">
                <thead className="bg-light rounded-3">
                  <tr>
                    <th className="py-2 px-3 rounded-start text-muted small fw-semibold">Date</th>
                    <th className="py-2 px-3 text-muted small fw-semibold">Plan</th>
                    <th className="py-2 px-3 text-muted small fw-semibold">Amount</th>
                    <th className="py-2 px-3 rounded-end text-muted small fw-semibold">Status</th>
                  </tr>
                </thead>
                <tbody>
                  {requestHistory.map((req) => (
                    <tr key={req.id} className="border-bottom">
                      <td className="py-3 px-3 text-muted small">{new Date(req.purchaseDate).toLocaleDateString('en-GB')}</td>
                      <td className="py-3 px-3 fw-semibold">{req.selectedPlan} <span className="text-muted fw-normal" style={{fontSize:"11px"}}>({req.billingDuration})</span></td>
                      <td className="py-3 px-3 fw-bold text-primary">₹{req.amount}</td>
                      <td className="py-3 px-3">
                        <span className={`badge rounded-pill px-3 py-2 ${
                          req.status.toLowerCase() === 'approved' ? 'bg-success' : 
                          req.status.toLowerCase() === 'rejected' ? 'bg-danger' : 
                          'bg-warning text-dark'
                        }`}>
                          {req.status.charAt(0).toUpperCase() + req.status.slice(1)}
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>

      <h5 className="fw-bold text-dark mb-4 px-2">Available Plans</h5>

      {loading ? (
        <div className="text-center py-5">
          <div className="spinner-border text-primary" role="status">
            <span className="visually-hidden">Loading...</span>
          </div>
          <p className="mt-2 text-muted">Loading available plans...</p>
        </div>
      ) : plans.length === 0 ? (
        <div className="card shadow-sm border-0 rounded-4 text-center py-5">
          <div className="card-body">
            <h5 className="text-muted">No plans available right now.</h5>
            <p className="text-muted small">Please contact the Super Admin.</p>
          </div>
        </div>
      ) : (
        <div className="row">
          {/* Plan Selection Area */}
          <div className="col-lg-8 mb-4">
            <div className="row g-4">
              {plans.map((plan) => (
                <div className="col-md-6" key={plan.id}>
                  <div 
                    className={`card h-100 border-2 rounded-4 transition-all shadow-sm ${selectedPlanId === plan.id ? 'border-primary bg-primary bg-opacity-10' : 'border-light'}`}
                    style={{ cursor: "pointer", transition: "all 0.3s ease" }}
                    onClick={() => handlePlanSelect(plan)}
                  >
                    <div className="card-body p-4 position-relative">
                      {selectedPlanId === plan.id && (
                        <div className="position-absolute top-0 end-0 mt-3 me-3 text-primary">
                          <FaCheck size={20} />
                        </div>
                      )}
                      
                      <div className="mb-3 d-flex align-items-center gap-2">
                        <FaCrown size={24} className={selectedPlanId === plan.id ? 'text-primary' : 'text-warning'} />
                        <h4 className="fw-bold mb-0">{plan.name}</h4>
                      </div>
                      
                      <h2 className="fw-bold mb-1">₹{plan.price}</h2>
                      <p className="text-muted small mb-3">per {plan.duration.toLowerCase()}</p>
                      
                      <span className="badge bg-dark rounded-pill mb-3 px-3 py-2">{plan.category}</span>
                      
                      {plan.description && (
                        <div className="mt-3 pt-3 border-top border-light">
                          <p className="text-muted small mb-0" style={{ whiteSpace: "pre-wrap" }}>{plan.description}</p>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Request Form Area */}
          <div className="col-lg-4">
            <div className="card shadow-sm border-0 rounded-4 sticky-top" style={{ top: "90px", zIndex: 10 }}>
              <div className="card-header bg-white border-bottom-0 pt-4 pb-0 px-4">
                <h5 className="fw-bold text-dark mb-0">Request Plan</h5>
              </div>
              <div className="card-body p-4">
                <div className="mb-3">
                  <label className="form-label fw-semibold text-muted small">Selected Plan</label>
                  <div className="form-control bg-light fw-bold border-0">
                    {plans.find(p => p.id === selectedPlanId)?.name || "None selected"}
                  </div>
                </div>

                <div className="mb-3">
                  <label className="form-label fw-semibold text-muted small">Billing Duration</label>
                  <select 
                    className="form-select border-1"
                    value={billingDuration}
                    onChange={(e) => setBillingDuration(e.target.value)}
                  >
                    <option value="Monthly">Monthly</option>
                    <option value="Yearly">Yearly</option>
                  </select>
                </div>

                <div className="mb-4">
                  <label className="form-label fw-semibold text-muted small">Plan Amount / Funds (₹)</label>
                  <input 
                    type="number" 
                    className="form-control border-1 fw-bold text-primary" 
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                    placeholder="Enter amount"
                  />
                  <small className="text-muted" style={{ fontSize: "11px" }}>You can manually adjust the amount if agreed upon with the Super Admin.</small>
                </div>

                <div className="bg-light p-3 rounded-3 mb-4">
                  <div className="d-flex align-items-center gap-2 text-muted small mb-2">
                    <FaCalendarAlt />
                    <span>Starts: Immediately upon approval</span>
                  </div>
                  <p className="small text-muted mb-0">
                    Your request will be sent to the Super Admin for offline payment verification.
                  </p>
                </div>

                <button 
                  className="btn btn-primary w-100 py-3 rounded-pill fw-bold shadow-sm"
                  onClick={openConfirmation}
                  disabled={!selectedPlanId}
                >
                  Review Request
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Confirmation Modal */}
      {showModal && (
        <div className="modal fade show d-block" style={{ backgroundColor: "rgba(0,0,0,0.5)" }} tabIndex="-1">
          <div className="modal-dialog modal-dialog-centered">
            <div className="modal-content rounded-4 border-0 shadow-lg">
              <div className="modal-header border-bottom-0 pb-0">
                <h5 className="modal-title fw-bold">Confirm Plan Request</h5>
                <button type="button" className="btn-close" onClick={() => setShowModal(false)}></button>
              </div>
              <div className="modal-body">
                <p className="text-muted small mb-4">Please review your details before submitting the request to the Super Admin.</p>
                
                <div className="bg-light rounded-3 p-3 mb-3">
                  <h6 className="fw-bold mb-3 border-bottom pb-2">Admin Details</h6>
                  <div className="row g-2 small">
                    <div className="col-5 text-muted">Admin Name:</div>
                    <div className="col-7 fw-semibold">{user?.fullName || "N/A"}</div>
                    
                    <div className="col-5 text-muted">Phone:</div>
                    <div className="col-7 fw-semibold">{user?.phone || "N/A"}</div>
                    
                    <div className="col-5 text-muted">Email:</div>
                    <div className="col-7 fw-semibold">{user?.email || "N/A"}</div>
                    
                    <div className="col-5 text-muted">Branch:</div>
                    <div className="col-7 fw-semibold">{user?.branchName || "N/A"}</div>
                  </div>
                </div>

                <div className="bg-primary bg-opacity-10 rounded-3 p-3">
                  <h6 className="fw-bold mb-3 border-bottom border-primary border-opacity-25 pb-2 text-primary">Plan Details</h6>
                  <div className="row g-2 small">
                    <div className="col-5 text-muted">Selected Plan:</div>
                    <div className="col-7 fw-bold">{plans.find(p => p.id === selectedPlanId)?.name}</div>
                    
                    <div className="col-5 text-muted">Duration:</div>
                    <div className="col-7 fw-semibold">{billingDuration}</div>
                    
                    <div className="col-5 text-muted">Payment Amount:</div>
                    <div className="col-7 fw-bold fs-5 text-primary">₹{amount}</div>
                  </div>
                </div>
              </div>
              <div className="modal-footer border-top-0 pt-0">
                <button type="button" className="btn btn-light rounded-pill px-4" onClick={() => setShowModal(false)} disabled={submitting}>Cancel</button>
                <button type="button" className="btn btn-primary rounded-pill px-4" onClick={handleSubmitRequest} disabled={submitting}>
                  {submitting ? "Submitting..." : "Confirm & Submit"}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AdminMySubscription;
