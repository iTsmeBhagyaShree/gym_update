import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faMedal, faFire, faDumbbell, faBalanceScale } from '@fortawesome/free-solid-svg-icons';
import './MemberLeaderboard.css';

const MemberLeaderboard = () => {
  const [activeTab, setActiveTab] = useState('fat_loss');
  const [leaderboardData, setLeaderboardData] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetchLeaderboard();
  }, [activeTab]);

  const fetchLeaderboard = async () => {
    try {
      setLoading(true);
      const user = JSON.parse(localStorage.getItem('user'));
      const branchId = user?.branchId || 1; 
      const token = localStorage.getItem('token');
      
      const response = await axios.get(`http://localhost:4000/api/v1/leaderboard?branchId=${branchId}&goal=${activeTab}`, {
        headers: { Authorization: `Bearer ${token}` }
      });

      if (response.data.status) {
        setLeaderboardData(response.data.data);
      }
    } catch (error) {
      console.error("Error fetching leaderboard", error);
    } finally {
      setLoading(false);
    }
  };

  const renderPodium = () => {
    const top3 = leaderboardData.slice(0, 3);
    if (top3.length === 0) return <div className="text-center text-muted my-5">No rankings available yet.</div>;

    // Podium positions: 2, 1, 3 for visual rendering
    const order = [1, 0, 2];
    
    return (
      <div className="podium-container d-flex justify-content-center align-items-end mt-4 mb-5">
        {order.map((index) => {
          const member = top3[index];
          if (!member) return <div key={`placeholder-${index}`} className="podium-placeholder"></div>;
          
          const isWinner = index === 0;
          return (
            <div key={member.memberId} className={`podium-step step-${index + 1} d-flex flex-column align-items-center mx-2`}>
              <div className="podium-avatar mb-2 position-relative">
                {isWinner && <FontAwesomeIcon icon={faMedal} className="winner-crown position-absolute text-warning" />}
                <img 
                  src={member.avatar ? `http://localhost:4000${member.avatar}` : "https://ui-avatars.com/api/?name=" + member.fullName} 
                  alt={member.fullName} 
                  className={`rounded-circle shadow-sm ${isWinner ? 'winner-avatar border border-3 border-warning' : 'border border-2 border-secondary'}`} 
                />
              </div>
              <div className="text-center fw-bold mb-1 text-dark">{member.fullName}</div>
              <div className="text-success fw-bold score-badge bg-light px-2 rounded mb-2">{member.score} pts</div>
              <div className={`podium-base base-${index + 1} mt-2 d-flex justify-content-center align-items-center text-white fw-bold fs-3 shadow rounded-top`}>
                {index + 1}
              </div>
            </div>
          );
        })}
      </div>
    );
  };

  const renderList = () => {
    const others = leaderboardData.slice(3);
    if (others.length === 0) return null;

    return (
      <div className="leaderboard-list mt-5">
        <h5 className="mb-3 text-secondary border-bottom pb-2">Global Rankings</h5>
        <div className="list-group shadow-sm">
          {others.map((member) => (
            <div key={member.memberId} className="list-group-item d-flex justify-content-between align-items-center border-0 border-bottom py-3 list-item-custom">
              <div className="d-flex align-items-center">
                <div className="rank-circle fw-bold text-secondary me-3 d-flex justify-content-center align-items-center rounded-circle bg-light" style={{width: '35px', height: '35px'}}>
                  {member.rank}
                </div>
                <img 
                  src={member.avatar ? `http://localhost:4000${member.avatar}` : "https://ui-avatars.com/api/?name=" + member.fullName} 
                  alt={member.fullName} 
                  className="rounded-circle me-3 list-avatar border border-2 border-light" 
                  width="45" height="45"
                />
                <span className="fw-bold text-dark">{member.fullName}</span>
              </div>
              <div className="score-badge text-success fw-bold bg-success bg-opacity-10 px-3 py-1 rounded-pill">
                {member.score} pts
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  };

  return (
    <div className="container mt-4 leaderboard-wrapper pb-5">
      <div className="text-center mb-5">
        <h1 className="fw-bold text-primary display-5">
          <FontAwesomeIcon icon={faMedal} className="me-3 text-warning" /> 
          GymCatalyst Leaderboard
        </h1>
        <p className="text-muted">Push your limits, track your progress, dominate the rankings.</p>
      </div>
      
      {/* Tabs */}
      <ul className="nav nav-pills nav-justified custom-tabs mb-4 p-1 bg-white shadow-sm rounded-pill">
        <li className="nav-item m-1">
          <button className={`nav-link rounded-pill fw-bold ${activeTab === 'fat_loss' ? 'active shadow-sm bg-primary' : 'text-dark'}`} onClick={() => setActiveTab('fat_loss')}>
            <FontAwesomeIcon icon={faFire} className="me-2" /> Fat Loss
          </button>
        </li>
        <li className="nav-item m-1">
          <button className={`nav-link rounded-pill fw-bold ${activeTab === 'muscle_gain' ? 'active shadow-sm bg-primary' : 'text-dark'}`} onClick={() => setActiveTab('muscle_gain')}>
            <FontAwesomeIcon icon={faDumbbell} className="me-2" /> Muscle Gain
          </button>
        </li>
        <li className="nav-item m-1">
          <button className={`nav-link rounded-pill fw-bold ${activeTab === 'maintenance' ? 'active shadow-sm bg-primary' : 'text-dark'}`} onClick={() => setActiveTab('maintenance')}>
            <FontAwesomeIcon icon={faBalanceScale} className="me-2" /> Maintenance
          </button>
        </li>
      </ul>

      {/* Content */}
      <div className="card shadow border-0 rounded-4 overflow-hidden">
        <div className="card-body p-4 p-md-5 bg-white">
          {loading ? (
            <div className="text-center my-5 py-5">
              <div className="spinner-border text-primary" role="status" style={{width: '3rem', height: '3rem'}}></div>
              <div className="mt-3 text-muted fw-bold fs-5">Crunching numbers...</div>
            </div>
          ) : (
            <>
              {renderPodium()}
              {renderList()}
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default MemberLeaderboard;
