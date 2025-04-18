import { randomBytes } from "node:crypto";
export const generateUniqueId = ()=> {
    return randomBytes(5).toString("hex").slice(0, 10);
}