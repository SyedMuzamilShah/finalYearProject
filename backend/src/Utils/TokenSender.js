// Filename - tokenSender.js


import nodemailer from 'nodemailer'

const transporter = nodemailer.createTransport({
    host: 'smtp-relay.brevo.com',
    port: 587,
    auth: {
      user: '8827a8002@smtp-brevo.com', // Your Sendinblue login email
      pass: '7kUfE9FAJxWMY2Dj', // Your Sendinblue SMTP key
    },
});

export const sendVerificationEmail = async (email, token) => {
    const verificationLink = `http://192.168.171.126:3000/verify?id=${token}`;
  
    const mailOptions = {
      from: 'syed.m.shah8989@gmail.com',
      to: email,
      subject: 'Verify Your Email',
      html: `
        <p>Click the link below to verify your email:</p>
        <a href="${verificationLink}">Verify Email</a>
        <p>Link expires in 1 hour.</p>
      `,
    };
  
    await transporter.sendMail(mailOptions, (err, info) => {
      if (err) {
        console.error('Error sending email:', err);
      } else {
        console.log('Email sent:', info.response);
      }
    });
};