-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PasswordReset" (
    "id" TEXT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PasswordReset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "division" VARCHAR(255) NOT NULL,
    "level" VARCHAR(255) NOT NULL,
    "eligibility" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT,

    CONSTRAINT "team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lineup" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "teamId" TEXT NOT NULL,

    CONSTRAINT "lineup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "athlete" (
    "id" TEXT NOT NULL,
    "firstName" VARCHAR(255) NOT NULL,
    "lastName" VARCHAR(255) NOT NULL,
    "eligibility" VARCHAR(255) NOT NULL,
    "paddleSide" VARCHAR(255) NOT NULL,
    "weight" INTEGER,
    "email" VARCHAR(255) NOT NULL,
    "notes" VARCHAR(255) NOT NULL,
    "isAvailable" BOOLEAN NOT NULL,
    "isManager" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "athlete_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "paddlerSkills" (
    "id" TEXT NOT NULL,
    "athleteId" TEXT NOT NULL,
    "isSteers" BOOLEAN NOT NULL,
    "isDrummer" BOOLEAN NOT NULL,
    "isStroker" BOOLEAN NOT NULL,
    "isCaller" BOOLEAN NOT NULL,
    "isBailer" BOOLEAN NOT NULL,
    "is200m" BOOLEAN NOT NULL,
    "is500m" BOOLEAN NOT NULL,
    "is1000m" BOOLEAN NOT NULL,
    "is2000m" BOOLEAN NOT NULL,
    "isVeteran" BOOLEAN NOT NULL,
    "isSteadyTempo" BOOLEAN NOT NULL,
    "isVocal" BOOLEAN NOT NULL,
    "isTechnicallyProficient" BOOLEAN NOT NULL,
    "isLeader" BOOLEAN NOT NULL,
    "isNewbie" BOOLEAN NOT NULL,
    "isRushing" BOOLEAN NOT NULL,
    "isLagging" BOOLEAN NOT NULL,
    "isTechnicallyPoor" BOOLEAN NOT NULL,
    "isInjuryProne" BOOLEAN NOT NULL,
    "isLoadManaged" BOOLEAN NOT NULL,
    "isPacer" BOOLEAN NOT NULL,
    "isEngine" BOOLEAN NOT NULL,
    "isRocket" BOOLEAN NOT NULL,

    CONSTRAINT "paddlerSkills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "athletesInTeams" (
    "teamId" TEXT NOT NULL,
    "athleteId" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "athletesInTeams_pkey" PRIMARY KEY ("teamId","athleteId")
);

-- CreateTable
CREATE TABLE "athletesInLineups" (
    "athleteId" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lineupId" TEXT NOT NULL,

    CONSTRAINT "athletesInLineups_pkey" PRIMARY KEY ("lineupId","athleteId")
);

-- CreateTable
CREATE TABLE "racePlan" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,

    CONSTRAINT "racePlan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "planSection" (
    "id" TEXT NOT NULL,
    "section" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "racePlanId" TEXT,

    CONSTRAINT "planSection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "regattaPlanSection" (
    "id" TEXT NOT NULL,
    "regattaName" TEXT NOT NULL,
    "regattaStartDate" TIMESTAMP(3),
    "regattaEndDate" TIMESTAMP(3),
    "regattaAddress" TEXT,
    "regattaContact" TEXT,
    "regattaEmail" TEXT,
    "regattaPhone" TEXT,
    "racePlanId" TEXT,

    CONSTRAINT "regattaPlanSection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mapPlanSection" (
    "id" TEXT NOT NULL,
    "mapName" TEXT NOT NULL,
    "mapLatitude" DOUBLE PRECISION NOT NULL,
    "mapLongitude" DOUBLE PRECISION NOT NULL,
    "mapZoom" DOUBLE PRECISION NOT NULL,
    "racePlanId" TEXT,

    CONSTRAINT "mapPlanSection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "eventPlanSection" (
    "id" TEXT NOT NULL,
    "eventName" TEXT,
    "eventTime" TIMESTAMP(3),
    "eventDistance" TEXT,
    "eventLane" TEXT,
    "racePlanId" TEXT,

    CONSTRAINT "eventPlanSection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LineupPlanSection" (
    "id" TEXT NOT NULL,
    "lineupName" TEXT,
    "lineupId" TEXT,
    "racePlanId" TEXT,

    CONSTRAINT "LineupPlanSection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notesPlanSection" (
    "id" TEXT NOT NULL,
    "notesName" TEXT,
    "notesBody" VARCHAR(255),
    "racePlanId" TEXT,

    CONSTRAINT "notesPlanSection_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_id_key" ON "user"("id");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "PasswordReset_email_key" ON "PasswordReset"("email");

-- CreateIndex
CREATE UNIQUE INDEX "athlete_email_key" ON "athlete"("email");

-- CreateIndex
CREATE UNIQUE INDEX "athlete_notes_key" ON "athlete"("notes");

-- CreateIndex
CREATE UNIQUE INDEX "paddlerSkills_athleteId_key" ON "paddlerSkills"("athleteId");

-- CreateIndex
CREATE UNIQUE INDEX "notesPlanSection_notesBody_key" ON "notesPlanSection"("notesBody");

-- AddForeignKey
ALTER TABLE "team" ADD CONSTRAINT "team_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lineup" ADD CONSTRAINT "lineup_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "paddlerSkills" ADD CONSTRAINT "paddlerSkills_athleteId_fkey" FOREIGN KEY ("athleteId") REFERENCES "athlete"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "athletesInTeams" ADD CONSTRAINT "athletesInTeams_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "athletesInTeams" ADD CONSTRAINT "athletesInTeams_athleteId_fkey" FOREIGN KEY ("athleteId") REFERENCES "athlete"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "athletesInLineups" ADD CONSTRAINT "athletesInLineups_lineupId_fkey" FOREIGN KEY ("lineupId") REFERENCES "lineup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "athletesInLineups" ADD CONSTRAINT "athletesInLineups_athleteId_fkey" FOREIGN KEY ("athleteId") REFERENCES "athlete"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "racePlan" ADD CONSTRAINT "racePlan_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "planSection" ADD CONSTRAINT "planSection_racePlanId_fkey" FOREIGN KEY ("racePlanId") REFERENCES "racePlan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regattaPlanSection" ADD CONSTRAINT "regattaPlanSection_racePlanId_fkey" FOREIGN KEY ("racePlanId") REFERENCES "racePlan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mapPlanSection" ADD CONSTRAINT "mapPlanSection_racePlanId_fkey" FOREIGN KEY ("racePlanId") REFERENCES "racePlan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "eventPlanSection" ADD CONSTRAINT "eventPlanSection_racePlanId_fkey" FOREIGN KEY ("racePlanId") REFERENCES "racePlan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LineupPlanSection" ADD CONSTRAINT "LineupPlanSection_racePlanId_fkey" FOREIGN KEY ("racePlanId") REFERENCES "racePlan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notesPlanSection" ADD CONSTRAINT "notesPlanSection_racePlanId_fkey" FOREIGN KEY ("racePlanId") REFERENCES "racePlan"("id") ON DELETE CASCADE ON UPDATE CASCADE;
