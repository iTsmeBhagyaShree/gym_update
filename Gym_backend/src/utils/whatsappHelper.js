// Removed axios import to prevent crash

// NOTE: Replace with your actual WhatsApp API credentials
const WHATSAPP_API_URL = process.env.WHATSAPP_API_URL || "https://api.whatsapp.com/v1/messages";
const WHATSAPP_TOKEN = process.env.WHATSAPP_TOKEN || "YOUR_TOKEN";

/**
 * Send a WhatsApp message
 * @param {string} phone - Member's phone number with country code (e.g. "919876543210")
 * @param {string} message - The text message to send
 */
export const sendWhatsAppMessage = async (phone, message) => {
  try {
    if (!phone) {
      console.warn("⚠️ WhatsApp Helper: Phone number is missing. Cannot send message.");
      return false;
    }

    console.log(`💬 [WhatsApp API] Sending message to ${phone}:`);
    console.log(`"${message}"`);

    // DUMMY IMPLEMENTATION (Uncomment and configure below for real API)
    /*
    const response = await axios.post(
      WHATSAPP_API_URL,
      {
        messaging_product: "whatsapp",
        to: phone,
        type: "text",
        text: { body: message }
      },
      {
        headers: {
          "Authorization": `Bearer ${WHATSAPP_TOKEN}`,
          "Content-Type": "application/json"
        }
      }
    );
    return response.data;
    */
    
    return true; // Simulate success
  } catch (error) {
    console.error("❌ WhatsApp Helper Error:", error.response?.data || error.message);
    return false;
  }
};

/**
 * Send a Payment Receipt
 */
export const sendPaymentReceipt = async (phone, memberName, amount, planName) => {
  const msg = `Hi ${memberName}, \n\nThank you for your payment of Rs.${amount} for the ${planName} plan. \n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management`;
  return sendWhatsAppMessage(phone, msg);
};

/**
 * Send a Payment Reminder
 */
export const sendPaymentReminder = async (phone, memberName, planName, dueDate) => {
  const msg = `Hi ${memberName}, \n\nThis is a friendly reminder that your ${planName} gym membership is expiring on ${dueDate}. \n\nPlease renew soon to continue your fitness journey without interruption. \n\nRegards,\nGym Management`;
  return sendWhatsAppMessage(phone, msg);
};
