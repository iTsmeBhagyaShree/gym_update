import React, { useState, useEffect } from 'react';
import axiosInstance from '../../Api/axiosInstance';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faClock, faBan, faDownload, faFilePdf } from '@fortawesome/free-solid-svg-icons';
import * as XLSX from 'xlsx';

const SuperAdminRenewals = () => {
  const [upcoming, setUpcoming] = useState([]);
  const [expired, setExpired] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchRenewals();
  }, []);

  const fetchRenewals = async () => {
    try {
      const res = await axiosInstance.get('/dashboard/renewals');
      if (res.data.success) {
        setUpcoming(res.data.data.upcomingRenewals);
        setExpired(res.data.data.expiredRenewals);
      }
    } catch (err) {
      console.error('Error fetching renewals:', err);
    } finally {
      setLoading(false);
    }
  };

  const exportCSV = (data, filename) => {
    const formattedData = data.map(item => ({
      "Gym Name": item.gymName || 'N/A',
      "Owner Name": item.fullName,
      "Email": item.email,
      "Phone": item.phone || 'N/A',
      "Plan": item.subscriptionPlan || 'N/A',
      "Expiry Date": new Date(item.licenseExpiryDate).toLocaleDateString(),
      "Status": item.isTrial ? 'Trial' : 'Paid'
    }));

    const worksheet = XLSX.utils.json_to_sheet(formattedData);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Renewals");
    XLSX.writeFile(workbook, `${filename}.xlsx`);
  };

  // Simple CSV text export as fallback if needed, but XLSX works better.
  const exportPDFPlaceholder = () => {
    alert("PDF Export functionality will be enabled soon. Please use Excel/CSV export for now.");
  };

  if (loading) return null;

  return (
    <div className="mt-4">
      <div className="row g-4">
        {/* Upcoming Renewals */}
        <div className="col-lg-6">
          <div className="card shadow-sm border-0 rounded-4 h-100">
            <div className="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center">
              <h5 className="mb-0 fw-bold text-warning">
                <FontAwesomeIcon icon={faClock} className="me-2" /> 
                Upcoming Renewals (7 Days)
              </h5>
              <div className="dropdown">
                <button className="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                  Export
                </button>
                <ul className="dropdown-menu">
                  <li><button className="dropdown-item" onClick={() => exportCSV(upcoming, 'Upcoming_Renewals')}><FontAwesomeIcon icon={faDownload} className="me-2 text-success" /> Excel / CSV</button></li>
                  <li><button className="dropdown-item" onClick={exportPDFPlaceholder}><FontAwesomeIcon icon={faFilePdf} className="me-2 text-danger" /> PDF</button></li>
                </ul>
              </div>
            </div>
            <div className="card-body p-0">
              <div className="table-responsive" style={{ maxHeight: '350px', overflowY: 'auto' }}>
                <table className="table table-hover mb-0 align-middle">
                  <thead className="bg-light text-muted sticky-top">
                    <tr>
                      <th className="px-4 py-3">Gym</th>
                      <th>Owner</th>
                      <th>Expiry</th>
                      <th>Plan</th>
                    </tr>
                  </thead>
                  <tbody>
                    {upcoming.length === 0 ? (
                      <tr><td colSpan="4" className="text-center py-4 text-muted">No upcoming renewals in next 7 days.</td></tr>
                    ) : upcoming.map(u => (
                      <tr key={u.id}>
                        <td className="px-4 py-3 fw-bold text-dark">{u.gymName || 'N/A'}</td>
                        <td>
                          <div>{u.fullName}</div>
                          <div className="text-muted" style={{ fontSize: '11px' }}>{u.phone}</div>
                        </td>
                        <td className="text-warning fw-bold">{new Date(u.licenseExpiryDate).toLocaleDateString()}</td>
                        <td><span className="badge bg-primary bg-opacity-10 text-primary">{u.subscriptionPlan || 'N/A'}</span></td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>

        {/* Expired / Inactive */}
        <div className="col-lg-6">
          <div className="card shadow-sm border-0 rounded-4 h-100">
            <div className="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center">
              <h5 className="mb-0 fw-bold text-danger">
                <FontAwesomeIcon icon={faBan} className="me-2" /> 
                Expired / Inactive Subscriptions
              </h5>
              <div className="dropdown">
                <button className="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                  Export
                </button>
                <ul className="dropdown-menu">
                  <li><button className="dropdown-item" onClick={() => exportCSV(expired, 'Expired_Renewals')}><FontAwesomeIcon icon={faDownload} className="me-2 text-success" /> Excel / CSV</button></li>
                  <li><button className="dropdown-item" onClick={exportPDFPlaceholder}><FontAwesomeIcon icon={faFilePdf} className="me-2 text-danger" /> PDF</button></li>
                </ul>
              </div>
            </div>
            <div className="card-body p-0">
              <div className="table-responsive" style={{ maxHeight: '350px', overflowY: 'auto' }}>
                <table className="table table-hover mb-0 align-middle">
                  <thead className="bg-light text-muted sticky-top">
                    <tr>
                      <th className="px-4 py-3">Gym</th>
                      <th>Owner</th>
                      <th>Expired On</th>
                      <th>Plan</th>
                    </tr>
                  </thead>
                  <tbody>
                    {expired.length === 0 ? (
                      <tr><td colSpan="4" className="text-center py-4 text-muted">No expired subscriptions.</td></tr>
                    ) : expired.map(e => (
                      <tr key={e.id}>
                        <td className="px-4 py-3 fw-bold text-dark">{e.gymName || 'N/A'}</td>
                        <td>
                          <div>{e.fullName}</div>
                          <div className="text-muted" style={{ fontSize: '11px' }}>{e.phone}</div>
                        </td>
                        <td className="text-danger fw-bold">{new Date(e.licenseExpiryDate).toLocaleDateString()}</td>
                        <td><span className="badge bg-secondary bg-opacity-10 text-secondary">{e.subscriptionPlan || 'N/A'}</span></td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SuperAdminRenewals;
