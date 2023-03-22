/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.security;

import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;
import jakarta.mail.BodyPart;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import java.util.Properties;

/**
 *
 * @author QuangQui
 */
public class MailSender {

    public boolean Send(String filePath, String result, String phone, String orderID, String orderTime, String name, String email, String deliveryAddress, String totalbill, String paymentMethod) {
        String emailContent = "";
        //Processing send email
        final String usernameEmail = "fivestorecantho@gmail.com";
        final String passwordEmail = "kpsmhoxyybmkwkio";
        String from = "fivestorecantho@gmail.com";

        String host = "smtp.gmail.com";
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", usernameEmail);
        props.put("mail.smtp.pass", "kpsmhoxyybmkwkio");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.charset", "utf-8");
        //create the Session object
        Session session = Session.getInstance(props,
                new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usernameEmail, passwordEmail);
            }
        });
        phone = phone.replaceAll("[^0-9]", ""); // xóa bỏ ký tự không phải là số
        phone = "+84" + phone.substring(1); // chuyển đổi thành định dạng +84
        try {
            emailContent = "Thông tin đơn hàng:\n\n"
                    + "Mã đơn hàng: " + orderID + "\n\n"
                    + "Ngày mua: " + orderTime + "\n\n"
                    + "Khách hàng: " + name + "\n\n"
                    + "Số điện thoại: " + phone + "\n\n"
                    + "Địa chỉ giao hàng: " + deliveryAddress + "\n\n"
                    + "Tổng giá trị đơn hàng: " + totalbill + "\n\n"
                    + "Phương thức thanh toán: " + paymentMethod + "\n\n"
                    + "Danh sách sản phẩm:\n" + result;
            Invoice invoice = new Invoice();
            invoice.createInvoice(name, deliveryAddress, orderTime, totalbill, result, filePath);
            // Tạo đối tượng Message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Information Order " + orderID + " " + orderTime);

            // Tạo phần thân email bao gồm nội dung text và file PDF đính kèm
            MimeMultipart multipart = new MimeMultipart();
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(emailContent, "text/plain; charset=UTF-8");
            multipart.addBodyPart(messageBodyPart);

            // Đính kèm file PDF vào phần thân email
            messageBodyPart = new MimeBodyPart();
            DataSource source = new FileDataSource(filePath);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName("Invoice.pdf");
            multipart.addBodyPart(messageBodyPart);

            // Thêm phần thân email vào đối tượng Message
            message.setContent(multipart);
            Transport.send(message);
            OTPSender otpSender = new OTPSender("AC47851346febff700998989a923642839", "6d0fd9463d75a21fba040ddd9b3924c0", "+15077055733");
            otpSender.sendOTP(phone, emailContent);
            return true;
        } catch (MessagingException e) {
        }
        return false;
    }
}
