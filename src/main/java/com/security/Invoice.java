/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.security;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class Invoice {

    public void createInvoice(String name, String deliveryAddress, String orderTime, String totalBill, String result, String filePath) {
        // Create PDF document
        Document document = new Document();
        try {
            PdfWriter.getInstance(document, new FileOutputStream(filePath));
            document.open();

            // Add content to PDF document
            Font fontTitle = new Font(Font.FontFamily.TIMES_ROMAN, 24, Font.BOLD);
            Font fontSubtitle = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
            Font fontTableHeader = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            // Tạo BaseFont từ font Times New Roman
            BaseFont bf = BaseFont.createFont("C:\\Windows\\Fonts\\times.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

            // Tạo font sử dụng BaseFont
            Font font = new Font(bf, 12);

            Paragraph title = new Paragraph("INVOICE", fontTitle);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph customerInfo = new Paragraph();
            customerInfo.add(new Phrase("Customer: ", fontSubtitle));
            customerInfo.add(new Phrase(name, font));
            customerInfo.add(new Phrase("\nDelivery Address: ", fontSubtitle));
            customerInfo.add(new Phrase(deliveryAddress, font));
            document.add(customerInfo);

            Paragraph orderInfo = new Paragraph();
            orderInfo.add(new Phrase("Order Time: ", fontSubtitle));
            orderInfo.add(new Phrase(orderTime, font));
            orderInfo.add(new Phrase("\nTotal Bill: ", fontSubtitle));
            orderInfo.add(new Phrase(totalBill, font));
            document.add(orderInfo);

            // Add products to PDF document
            String[] products = result.split("\n");
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);
            PdfPCell cell;

            cell = new PdfPCell(new Phrase("Product", fontTableHeader));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(5);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("Quantity", fontTableHeader));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(5);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("Total", fontTableHeader));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(5);
            table.addCell(cell);

            for (String product : products) {
                String[] productInfo = product.trim().split("\\s{2,}");
                table.addCell(new Phrase(productInfo[0], font));
                table.addCell(new Phrase(productInfo[1], font));
                table.addCell(new Phrase(productInfo[2], font));
            }

            document.add(table);
            document.close();
        } catch (IOException | DocumentException e) {
            e.printStackTrace();
        }
    }

    void createInvoice(String name, String deliveryAddress, String orderTime, int parseInt, String result, String filePath) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
