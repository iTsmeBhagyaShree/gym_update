import app from "./app.js";
import { ENV } from "./config/env.js";
import "./modules/alert/alert.corn.js";
import "./modules/notifications/notif.corn.js";
import { initTrialCronJobs } from "./cron/trial.cron.js";

// Initialize scheduled tasks
initTrialCronJobs();

app.listen(ENV.port, () => {
  console.log(`Server running on http://localhost:${ENV.port}`);
});