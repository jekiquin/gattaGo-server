import { Request, Response } from "express";
import {
  findUser,
  findResetCode,
  createResetCode,
  deleteResetCode,
  changePassword,
  findMatchingUserWithResetCode,
} from "../services/reset.services";
import { sendEmail } from "../utils/nodemailer.utils";
import { hashEntity } from "../utils/bcrypt.utils";

interface MailOptions {
  from: String;
  to: String;
  subject: String;
  text: String;
}

const getUserEmail = async (req: Request, res: Response) => {
  const { resetCodeId } = req.params;
  if (!resetCodeId) return res.status(400).send("No reset code sent!");

  //  Find corresponding email in user schema
  try {
    const foundEmail = await findMatchingUserWithResetCode(resetCodeId);
    return res.status(200).send({ foundEmail });
  } catch (err) {
    return res.status(404).send("Invalid reset code!");
  }
};

const resetPassword = async (req: Request, res: Response) => {
  const { email } = req.body;
  if (!email) return res.status(400).send("No email field!");

  try {
    await findUser(email);
  } catch {
    return res
      .status(400)
      .send("Email does not exist! Cannot reset password...");
  }

  try {
    const resetCode = await createResetCode(email);
    sendEmail(
      email,
      "Password reset for",
      "Looks like you want to reset your password. Click on the link below! Your link will expire within 10 minutes!",
      "resetEmail",
      resetCode
    );
  } catch {
    console.log("Can't send reset code!");
    return res.status(400).send("Cannot send reset code!");
  }

  res.status(200).send("Password reset code sent!");
};

const updatePassword = async (req: Request, res: Response) => {
  const { email, password, resetCode } = req.body;
  if (!email || !password || !resetCode)
    return res.status(400).send("Ensure all fields are inputted!");

  try {
    await findUser(email);
  } catch {
    return res
      .status(400)
      .send("Email does not exist! Cannot reset password...");
  }

  try {
    await findResetCode(resetCode);

    const hashedPassword: string = await hashEntity(password);
    await changePassword(email, hashedPassword);

    sendEmail(
      email,
      "Password successfully reset for",
      "Your password has been successfully reset!",
      "confirmEmail"
    );
  } catch {
    return res.status(400).send("Could not reset password!");
  } finally {
    deleteResetCode(email);
  }

  res.status(204).send("Password updated!");
};

export { resetPassword, updatePassword, getUserEmail };
