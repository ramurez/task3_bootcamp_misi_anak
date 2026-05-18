import z from "zod";

export const CreateParentSchema = z.object({
  name: z.string(),
  age: z.number().min(0),
});
