import { zValidator } from "@hono/zod-validator";
import { Hono } from "hono";
import { prisma } from "../../utils/prisma";
import { CreateParentSchema } from "./schema";

export const parentRouter = new Hono()
	.get("/", async (c) => {
		const parents = await prisma.parent.findMany();
		return c.json(parents);
	})
	.get("/:id", async (c) => {
		const id = c.req.param("id");
		if (id === ".well-known") {
			return new Response(null, { status: 404 });
		}
		const parent = await prisma.parent.findUnique({
			where: {
				id: Number(id),
			},
		});
		return c.json(parent);
	})
	.delete("/:id", async (c) => {
		const id = c.req.param("id");
		const parent = await prisma.parent.delete({
			where: {
				id: Number(id),
			},
		});
		return c.json(parent);
	})
	.post("/", zValidator("json", CreateParentSchema), async (c) => {
		const body = c.req.valid("json");
		const newParent = await prisma.parent.create({
			data: {
				name: body.name,
				age: body.age,
			},
		});
		return c.json(newParent);
	});
