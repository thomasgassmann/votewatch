-- DropForeignKey
ALTER TABLE "Bill" DROP CONSTRAINT "Bill_sponsorId_fkey";

-- AlterTable
ALTER TABLE "Bill" ALTER COLUMN "sponsorId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Bill" ADD CONSTRAINT "Bill_sponsorId_fkey" FOREIGN KEY ("sponsorId") REFERENCES "Parliamentarian"("id") ON DELETE SET NULL ON UPDATE CASCADE;
