import { Router } from "express";
import { confirmUserSelectedId, uniqueIdGenerator } from "../Controllers/CoreController.js"
const coreRoute = Router();

// ----------------------- Employee Auths Routes -----------------------
coreRoute
    .route("/create-uniqueId")
    .get(uniqueIdGenerator); 

coreRoute
    .route("/confirm-uniqueId")
    .get(confirmUserSelectedId); 

export { coreRoute };
