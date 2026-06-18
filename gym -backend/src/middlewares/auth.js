import jwt from "jsonwebtoken";
import { ENV } from "../config/env.js";

export const verifyToken = (roles = []) => {
  return (req, res, next) => {
    try {
      const authHeader = req.headers.authorization;
      if (!authHeader) throw { status: 401, message: "Token required" };

      const token = authHeader.split(" ")[1];
      const decoded = jwt.verify(token, ENV.jwtSecret);
      req.user = decoded;

      if (roles.length) {
        // Fallback mapping if role name string is missing in JWT payload
        let userRoleName = decoded.role;
        if (!userRoleName && decoded.roleId) {
          if (decoded.roleId === 1) userRoleName = "Superadmin";
          else if (decoded.roleId === 2) userRoleName = "Admin";
          else if (decoded.roleId === 4) userRoleName = "Member";
          else userRoleName = "Staff"; // covers other staff roles
        }

        if (!roles.includes(userRoleName)) {
          throw { status: 403, message: "Access denied" };
        }
      }

      next();
    } catch (err) {
      next(err);
    }
  };
};

// import jwt from "jsonwebtoken";
// import { ENV } from "../config/env.js";

// export const verifyToken = (roles = []) => {
//   return (req, res, next) => {
//     try {
//       const authHeader = req.headers.authorization;
//       if (!authHeader) throw { status: 401, message: "Token required" };

//       const token = authHeader.split(" ")[1];
//       const decoded = jwt.verify(token, ENV.jwtSecret);

//       req.user = decoded; // store token payload

//       // 🟢 If token belongs to a MEMBER → allow without role checking
//       if (decoded.memberId) {
//         return next();
//       }

//       // 🔵 For USER roles (Admin / Staff / Superadmin)
//       if (roles.length && !roles.includes(decoded.role)) {
//         throw { status: 403, message: "Access denied" };
//       }

//       next();
//     } catch (err) {
//       next(err);
//     }
//   };
// };
