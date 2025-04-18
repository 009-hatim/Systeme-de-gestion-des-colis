package service;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMail {

    private static final String USERNAME = "hatim305koubri@gmail.com";
    private static final String PASSWORD = "qsuk nzpv iylm wxfs";

    public static void send(String content, String toEmail) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Notification de connexion");
            message.setText(content);

            Transport.send(message);
            System.out.println("Email envoyé avec succès");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
