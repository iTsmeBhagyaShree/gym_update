import React, { useState, useEffect } from 'react';
import axios from 'axios';
import BaseUrl from '../../Api/BaseUrl';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faExclamationTriangle, faEnvelope, faPhone, faUserShield, faSync } from '@fortawesome/free-solid-svg-icons';

const AttendanceAlerts = () => {
  const [members, setMembers] = useState([]);
  const [loading, setLoading] = useState(true);

  // Message Modal States
  const [showMsgModal, setShowMsgModal] = useState(false);
  const [selectedMember, setSelectedMember] = useState(null);
  const [msgTemplate, setMsgTemplate] = useState('template1');
  const [customMsg, setCustomMsg] = useState('');
  const [sendingMsg, setSendingMsg] = useState(false);

  const user = JSON.parse(localStorage.getItem('user')) || {};
  const token = localStorage.getItem('token');
  const axiosConfig = { headers: { Authorization: `Bearer ${token}` } };

  const templates = {
    template1: "Hi {name}, we noticed you've been absent for a while. We miss you at the gym!",
    template2: "Hi {name}, consistency is key! Let us know if you need any help getting back on track.",
    template3: "Hi {name}, your fitness journey is important to us. Hope to see you back soon!"
  };

  const fetchVulnerableMembers = async () => {
    setLoading(true);
    try {
      const res = await axios.get(`${BaseUrl}alerts/vulnerable-members`, axiosConfig);
      if (res.data.success) {
        // Filter out Green members, we only care about Yellow and Red
        const filtered = res.data.members.filter(m => m.badge !== 'Green');
        setMembers(filtered);
      }
    } catch (err) {
      console.error("Error fetching vulnerable members", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchVulnerableMembers();
  }, []);

  const handleMessageClick = (member) => {
    setSelectedMember(member);
    const initialMsg = templates['template1'].replace('{name}', member.fullName);
    setMsgTemplate('template1');
    setCustomMsg(initialMsg);
    setShowMsgModal(true);
  };

  const handleTemplateChange = (e) => {
    const tpl = e.target.value;
    setMsgTemplate(tpl);
    if (tpl === 'custom') {
      setCustomMsg('');
    } else {
      setCustomMsg(templates[tpl].replace('{name}', selectedMember?.fullName || ''));
    }
  };

  const sendNotification = async () => {
    if (!customMsg.trim()) return alert("Message cannot be empty");
    if (!selectedMember?.email) return alert("Member does not have an email address on file.");
    
    setSendingMsg(true);
    try {
      const payload = {
        type: 'EMAIL',
        to: selectedMember.email,
        message: customMsg,
        memberId: selectedMember.id
      };
      
      const res = await axios.post(`${BaseUrl}notif/send`, payload, axiosConfig);
      if (res.data.success) {
        alert("Message queued for sending successfully!");
        setShowMsgModal(false);
      } else {
        alert("Failed to send message: " + (res.data.message || "Unknown error"));
      }
    } catch (err) {
      console.error("Error sending message", err);
      alert("Error sending message. Please ensure SMTP is configured in the backend.");
    } finally {
      setSendingMsg(false);
    }
  };

  return (
    <div className="container-fluid p-4" style={{ backgroundColor: '#f8f9fa', minHeight: '100vh' }}>
      <div className="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
        <div>
          <h2 className="mb-1 fw-bold text-dark d-flex align-items-center">
            <FontAwesomeIcon icon={faExclamationTriangle} className="text-warning me-3" />
            At-Risk Members (Attendance)
          </h2>
          <p className="text-muted mb-0 fs-6">Monitor members with irregular attendance or prolonged absence to improve retention.</p>
        </div>
        <button className="btn btn-primary shadow-sm" onClick={fetchVulnerableMembers}>
          <FontAwesomeIcon icon={faSync} className="me-2" /> Refresh
        </button>
      </div>

      <div className="row mb-4">
        <div className="col-md-6 mb-3">
          <div className="card border-0 shadow-sm rounded-4 h-100 border-start border-danger border-4">
            <div className="card-body p-4">
              <h6 className="text-muted mb-2 fw-semibold text-uppercase">High Risk (Red Badge)</h6>
              <h3 className="fw-bold text-dark mb-0">{members.filter(m => m.badge === 'Red').length} Members</h3>
              <p className="text-danger small mt-2 mb-0">&lt; 40% attendance or absent &gt; 15 days</p>
            </div>
          </div>
        </div>
        <div className="col-md-6 mb-3">
          <div className="card border-0 shadow-sm rounded-4 h-100 border-start border-warning border-4">
            <div className="card-body p-4">
              <h6 className="text-muted mb-2 fw-semibold text-uppercase">Irregular (Yellow Badge)</h6>
              <h3 className="fw-bold text-dark mb-0">{members.filter(m => m.badge === 'Yellow').length} Members</h3>
              <p className="text-warning small mt-2 mb-0">40% - 75% attendance or absent &gt; 7 days</p>
            </div>
          </div>
        </div>
      </div>

      <div className="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div className="card-header bg-white border-bottom p-4">
          <h5 className="mb-0 fw-bold text-dark">Member List</h5>
        </div>
        <div className="card-body p-0">
          <div className="table-responsive">
            <table className="table table-hover align-middle mb-0">
              <thead className="table-light">
                <tr>
                  <th className="px-4 py-3">Member Name</th>
                  <th className="py-3">Contact</th>
                  <th className="py-3">Days Absent</th>
                  <th className="py-3">30-Day Attendance %</th>
                  <th className="py-3">Status Badge</th>
                  <th className="py-3 text-end px-4">Actions</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr><td colSpan="6" className="text-center py-5">Loading members...</td></tr>
                ) : members.length > 0 ? (
                  members.sort((a, b) => b.daysAbsent - a.daysAbsent).map(member => (
                    <tr key={member.id}>
                      <td className="px-4 py-3 fw-semibold text-dark">
                        <div className="d-flex align-items-center">
                          <div className="bg-light rounded-circle d-flex align-items-center justify-content-center me-3" style={{ width: '40px', height: '40px' }}>
                            <FontAwesomeIcon icon={faUserShield} className="text-secondary" />
                          </div>
                          <div>
                            {member.fullName}
                            <span className="text-muted fs-6 d-block">ID: {member.id}</span>
                          </div>
                        </div>
                      </td>
                      <td className="py-3 text-muted">
                        <div>{member.phone}</div>
                        <div className="small">{member.email}</div>
                      </td>
                      <td className="py-3 fw-bold">
                        {member.daysAbsent === null ? 'Never Attended' : `${member.daysAbsent} Days`}
                      </td>
                      <td className="py-3">
                        <div className="d-flex align-items-center">
                          <span className="me-2">{member.attendancePercentage}%</span>
                          <div className="progress w-100" style={{ height: '6px' }}>
                            <div className={`progress-bar ${member.badge === 'Red' ? 'bg-danger' : 'bg-warning'}`} role="progressbar" style={{ width: `${member.attendancePercentage}%` }}></div>
                          </div>
                        </div>
                      </td>
                      <td className="py-3">
                        <span className={`badge rounded-pill ${member.badge === 'Red' ? 'bg-danger' : 'bg-warning text-dark'}`}>
                          {member.badge}
                        </span>
                      </td>
                      <td className="py-3 text-end px-4">
                        <button className="btn btn-sm btn-light me-2 text-primary border shadow-sm" title="Send Message" onClick={() => handleMessageClick(member)}>
                          <FontAwesomeIcon icon={faEnvelope} />
                        </button>
                        <a href={`tel:${member.phone}`} className="btn btn-sm btn-light me-2 text-success border shadow-sm" title="Call/WhatsApp">
                          <FontAwesomeIcon icon={faPhone} />
                        </a>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="6" className="text-center py-5 text-muted">
                      <p>Great job! No At-Risk members found.</p>
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      {/* Message Modal */}
      {showMsgModal && selectedMember && (
        <div className="modal d-block" tabIndex="-1" style={{ backgroundColor: 'rgba(0,0,0,0.5)', zIndex: 1050 }}>
          <div className="modal-dialog modal-dialog-centered">
            <div className="modal-content border-0 shadow">
              <div className="modal-header bg-primary text-white border-0">
                <h5 className="modal-title d-flex align-items-center">
                  <FontAwesomeIcon icon={faEnvelope} className="me-2 text-white" /> 
                  Message {selectedMember.fullName}
                </h5>
                <button type="button" className="btn-close btn-close-white" onClick={() => setShowMsgModal(false)}></button>
              </div>
              <div className="modal-body p-4">
                <div className="mb-3">
                  <label className="form-label fw-semibold text-muted small text-uppercase">Select Template</label>
                  <select className="form-select border-primary bg-light" value={msgTemplate} onChange={handleTemplateChange}>
                    <option value="template1">Template 1: We miss you</option>
                    <option value="template2">Template 2: Consistency is key</option>
                    <option value="template3">Template 3: Hope to see you back</option>
                    <option value="custom">Custom Message...</option>
                  </select>
                </div>
                <div className="mb-3">
                  <label className="form-label fw-semibold text-muted small text-uppercase">Message Content</label>
                  <textarea 
                    className="form-control" 
                    rows="4" 
                    value={customMsg}
                    onChange={(e) => setCustomMsg(e.target.value)}
                    placeholder="Type your message here..."
                  ></textarea>
                </div>
                <div className="alert alert-info py-2 small mb-0 d-flex align-items-center">
                  <FontAwesomeIcon icon={faEnvelope} className="me-2" />
                  This message will be sent via Email to {selectedMember.email || 'N/A'}.
                </div>
              </div>
              <div className="modal-footer border-0 bg-light">
                <button type="button" className="btn btn-secondary" onClick={() => setShowMsgModal(false)}>Cancel</button>
                <button type="button" className="btn btn-primary" onClick={sendNotification} disabled={sendingMsg}>
                  {sendingMsg ? 'Sending...' : 'Send Message'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AttendanceAlerts;

