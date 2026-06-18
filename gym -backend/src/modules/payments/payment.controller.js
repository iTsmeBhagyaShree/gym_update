import {
  recordPaymentService,
  paymentHistoryService,
  allPaymentsService,
} from "./payment.service.js";

export const recordPayment = async (req, res, next) => {
  try {
    const p = await recordPaymentService(req.body);
    res.json({ success: true, payment: p });
  } catch (err) {
    next(err);
  }
};

export const paymentHistory = async (req, res, next) => {
  try {
    const memberId = parseInt(req.params.memberId);
    const list = await paymentHistoryService(memberId);
    res.json({ success: true, payments: list });
  } catch (err) {
    next(err);
  }
};

export const allPayments = async (req, res, next) => {
  try {
    const branchId = req.params.branchId;
    const adminId = req.query.adminId; // Need adminId from query for proper fetching
    const list = await allPaymentsService(adminId, branchId);
    res.json({ success: true, payments: list });
  } catch (err) {
    next(err);
  }
};
