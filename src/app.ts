import express, { Express, Request, Response } from "express";
import * as dotenv from "dotenv";
dotenv.config();

const app: Express = express();
const PORT: string = process.env.PORT! || "8888";

app.get("/", (_req: Request, res: Response) => {
  res.send(`Paddles up! gattaGo is taking it away on PORT ${PORT}! 🚣🏼`);
});


//  Routing
import regattaRoute from "./api/regattas/regattaRoute";
//  teams
//  lineups
//  athletes

app.use(express.json());
app.use("/regattas", regattaRoute);

app.listen(PORT, () => {
  console.log(`Paddles up! gattaGo is taking it away on PORT ${PORT}! 🚣🏼`);
});
