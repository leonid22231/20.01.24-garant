package com.thedeveloper.garant.util;


import com.ibm.icu.text.RuleBasedNumberFormat;
import com.thedeveloper.garant.entity.CreditEntity;
import com.thedeveloper.garant.entity.DocumentEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.service.CreditService;
import com.thedeveloper.garant.service.DocumentFileService;
import com.thedeveloper.garant.service.DocumentService;
import com.thedeveloper.garant.service.ImageService;
import lombok.AllArgsConstructor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;


import java.io.*;
import java.nio.file.Path;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@AllArgsConstructor
public class CreditUtils {
    DocumentFileService documentFileService;
    CreditService creditService;
    DocumentService documentService;
    public void createCredit(CreditEntity credit) throws IOException {
        RuleBasedNumberFormat nf = new RuleBasedNumberFormat(Locale.forLanguageTag("ru"),
                RuleBasedNumberFormat.SPELLOUT);
        Resource resource = new ClassPathResource("doc.docx");
        try (InputStream inputStream = new FileInputStream(resource.getFile().getAbsolutePath())) {
            XWPFDocument doc = new XWPFDocument(inputStream);
            doc = replaceText(doc, "DOCNUM", String.valueOf(documentFileService.loadAll().count()+1));
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.y");
            doc = replaceText(doc, "TAVXB", dateFormat.format(new Date()));
            doc = replaceText(doc, "FROVR", credit.getBorrower().getIdentityCard());
            doc = replaceText(doc, "DOHBY", credit.getLender().getIdentityCard());
            doc = replaceText(doc, "ARIUB", String.valueOf(credit.getValue()));
            doc = replaceText(doc, "ERQWZ", nf.format(credit.getValue()));
            doc = replaceText(doc, "QNWRP", String.valueOf(credit.getDuration()));
            doc = replaceText(doc, "HQNOR", nf.format(credit.getDuration()));
            doc = replaceText(doc, "PLANP", credit.getBorrower().getSurname()+" "+credit.getBorrower().getName()+" "+credit.getBorrower().getPatronymic());
            doc = replaceText(doc, "LWYNW", credit.getLender().getSurname()+" "+credit.getLender().getName()+" "+credit.getLender().getPatronymic());
            doc = replaceText(doc, "ACSVE", "+"+credit.getBorrower().getPhone());
            doc = replaceText(doc, "UORTU", "+"+credit.getLender().getPhone());
            doc = replaceText(doc, "TVVYH", dateFormat.format(credit.getBorrower().getUserDate()));
            doc = replaceText(doc, "BWOMX", dateFormat.format(credit.getLender().getUserDate()));
            doc = replaceText(doc, "ILCLX", dateFormat.format(credit.getBorrower().getIdentityCardDay()));
            doc = replaceText(doc, "CQZTI", dateFormat.format(credit.getLender().getIdentityCardDay()));
            doc = replaceText(doc, "NBDBB", credit.getRequisites().getBankName());
            doc = replaceText(doc, "GARZQ", credit.getRequisites().getBikNumber());
            doc = replaceText(doc, "QUYXI", credit.getRequisites().getCardNumber());
            String name = "doc_"+String.valueOf(documentFileService.loadAll().count()+1)+".docx";
            Path path = documentFileService.getP().resolve(name);
            saveFile(path.normalize().toAbsolutePath().toString(), doc);
            doc.close();
            DocumentEntity documentEntity = new DocumentEntity();
            documentEntity.setFileName(name);
            documentService.save(documentEntity);
            credit.setDoc(documentEntity);
            creditService.save(credit);
        }

    }
    private static XWPFDocument replaceText(XWPFDocument doc, String originalText, String updatedText) {
        replaceTextInParagraphs(doc.getParagraphs(), originalText, updatedText);
        for (XWPFTable tbl : doc.getTables()) {
            for (XWPFTableRow row : tbl.getRows()) {
                for (XWPFTableCell cell : row.getTableCells()) {
                    replaceTextInParagraphs(cell.getParagraphs(), originalText, updatedText);
                }
            }
        }
        return doc;
    }
    private static void replaceTextInParagraphs(List<XWPFParagraph> paragraphs, String originalText, String updatedText) {
        paragraphs.forEach(paragraph -> replaceTextInParagraph(paragraph, originalText, updatedText));
    }
    private static void replaceTextInParagraph(XWPFParagraph paragraph, String originalText, String updatedText) {
        List<XWPFRun> runs = paragraph.getRuns();
        for (XWPFRun run : runs) {
            String text = run.getText(0);
            if (text != null && text.contains(originalText)) {
                String updatedRunText = text.replace(originalText, updatedText);
                run.setText(updatedRunText, 0);
            }
        }
    }
    private static void saveFile(String filePath, XWPFDocument doc) throws IOException {
        try (FileOutputStream out = new FileOutputStream(filePath)) {
            doc.write(out);
        }
    }
}
