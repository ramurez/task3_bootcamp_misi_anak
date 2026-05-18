import { Hono } from "hono";
import { prisma } from "../../utils/prisma";

export const authRouter = new Hono().post("/login", async (c) => {
	return c.json({ message: "Welcome ....!" });
});
