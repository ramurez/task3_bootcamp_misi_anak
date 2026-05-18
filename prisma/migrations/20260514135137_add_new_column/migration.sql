/*
  Warnings:

  - Added the required column `age` to the `Child` table without a default value. This is not possible if the table is not empty.
  - Added the required column `age` to the `Parent` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Child" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "parentId" INTEGER NOT NULL,
    CONSTRAINT "Child_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Parent" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Child" ("id", "name", "parentId") SELECT "id", "name", "parentId" FROM "Child";
DROP TABLE "Child";
ALTER TABLE "new_Child" RENAME TO "Child";
CREATE TABLE "new_Parent" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL
);
INSERT INTO "new_Parent" ("id", "name") SELECT "id", "name" FROM "Parent";
DROP TABLE "Parent";
ALTER TABLE "new_Parent" RENAME TO "Parent";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
