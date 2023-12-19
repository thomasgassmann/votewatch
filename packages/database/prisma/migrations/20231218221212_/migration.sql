-- CreateEnum
CREATE TYPE "InfluenceLevel" AS ENUM ('TIEF', 'MITTEL', 'HOCH', 'UNKNOWN');

-- CreateEnum
CREATE TYPE "VoteStatus" AS ENUM ('YES', 'NO', 'UNKNOWN');

-- CreateTable
CREATE TABLE "Canton" (
    "id" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Canton_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Parliamentarian" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cantonId" TEXT NOT NULL,
    "partyId" TEXT NOT NULL,

    CONSTRAINT "Parliamentarian_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Party" (
    "id" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,

    CONSTRAINT "Party_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ParliamentarianRelatedToOrganization" (
    "parliamentarianId" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "influenceLevel" "InfluenceLevel" NOT NULL DEFAULT 'UNKNOWN',
    "verguetung" TEXT,

    CONSTRAINT "ParliamentarianRelatedToOrganization_pkey" PRIMARY KEY ("parliamentarianId","organizationId")
);

-- CreateTable
CREATE TABLE "LobbyOrganization" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "rechtsform" TEXT NOT NULL,

    CONSTRAINT "LobbyOrganization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InterestGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "aliasNames" TEXT NOT NULL,

    CONSTRAINT "InterestGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bill" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "billText" TEXT NOT NULL,
    "sponsorId" TEXT NOT NULL,
    "voteResult" "VoteStatus" NOT NULL DEFAULT 'UNKNOWN',

    CONSTRAINT "Bill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ParliamentarianVote" (
    "parliamentarianId" TEXT NOT NULL,
    "billId" TEXT NOT NULL,
    "voteStatus" "VoteStatus" NOT NULL,

    CONSTRAINT "ParliamentarianVote_pkey" PRIMARY KEY ("parliamentarianId","billId")
);

-- CreateTable
CREATE TABLE "Committee" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Committee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_InterestGroupToLobbyOrganization" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_CommitteeToParliamentarian" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Canton_shortName_key" ON "Canton"("shortName");

-- CreateIndex
CREATE UNIQUE INDEX "_InterestGroupToLobbyOrganization_AB_unique" ON "_InterestGroupToLobbyOrganization"("A", "B");

-- CreateIndex
CREATE INDEX "_InterestGroupToLobbyOrganization_B_index" ON "_InterestGroupToLobbyOrganization"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CommitteeToParliamentarian_AB_unique" ON "_CommitteeToParliamentarian"("A", "B");

-- CreateIndex
CREATE INDEX "_CommitteeToParliamentarian_B_index" ON "_CommitteeToParliamentarian"("B");

-- AddForeignKey
ALTER TABLE "Parliamentarian" ADD CONSTRAINT "Parliamentarian_cantonId_fkey" FOREIGN KEY ("cantonId") REFERENCES "Canton"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Parliamentarian" ADD CONSTRAINT "Parliamentarian_partyId_fkey" FOREIGN KEY ("partyId") REFERENCES "Party"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParliamentarianRelatedToOrganization" ADD CONSTRAINT "ParliamentarianRelatedToOrganization_parliamentarianId_fkey" FOREIGN KEY ("parliamentarianId") REFERENCES "Parliamentarian"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParliamentarianRelatedToOrganization" ADD CONSTRAINT "ParliamentarianRelatedToOrganization_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "LobbyOrganization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bill" ADD CONSTRAINT "Bill_sponsorId_fkey" FOREIGN KEY ("sponsorId") REFERENCES "Parliamentarian"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParliamentarianVote" ADD CONSTRAINT "ParliamentarianVote_parliamentarianId_fkey" FOREIGN KEY ("parliamentarianId") REFERENCES "Parliamentarian"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParliamentarianVote" ADD CONSTRAINT "ParliamentarianVote_billId_fkey" FOREIGN KEY ("billId") REFERENCES "Bill"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_InterestGroupToLobbyOrganization" ADD CONSTRAINT "_InterestGroupToLobbyOrganization_A_fkey" FOREIGN KEY ("A") REFERENCES "InterestGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_InterestGroupToLobbyOrganization" ADD CONSTRAINT "_InterestGroupToLobbyOrganization_B_fkey" FOREIGN KEY ("B") REFERENCES "LobbyOrganization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CommitteeToParliamentarian" ADD CONSTRAINT "_CommitteeToParliamentarian_A_fkey" FOREIGN KEY ("A") REFERENCES "Committee"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CommitteeToParliamentarian" ADD CONSTRAINT "_CommitteeToParliamentarian_B_fkey" FOREIGN KEY ("B") REFERENCES "Parliamentarian"("id") ON DELETE CASCADE ON UPDATE CASCADE;
