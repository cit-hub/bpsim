package bpsim.module.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import java.util.HashMap;
import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.sun.javafx.font.FontFactory;

import bpsim.framework.dao.AbstractDao;
import kr.dogfoot.hwplib.object.bodytext.paragraph.Paragraph;

@Component("bpsimCommonService")
public class BpsimCommonService extends AbstractDao implements BpsimCommon{
	
	@Resource(name="sqlMapClientBase")
	protected void setSqlMap(SqlMapClient sqlMapClient){
		setSqlMapClient(sqlMapClient);
	}
	
	public void insert(String queryId, Map args) throws SQLException {
		regist(queryId, args);
		
	}
	
	public void update(String update, Map args) throws SQLException {
		modify(update, args);
	}
	
	public void delete(String queryId, Map args) throws SQLException {
		remove(queryId, args);
	}	
	
	public int getListCount(String queryId, Map args) throws SQLException {
		return getCount(queryId, args);
	}
	
	public int getDataCnt(String queryId, Map args) throws SQLException {
		return getCount(queryId, args);
	}
	
	public Object getDataString(String queryId, Map args) throws SQLException {
		return getValue(queryId, args);
	}
	
	public List getDataList(String queryId, Map args) throws SQLException {
		return getList(queryId, args);
	}
	
	public List getList(String queryId, Map args, int startIndex, int recordPerPage) throws SQLException {
		return getPageList(queryId, args, startIndex, recordPerPage);
	}
	
	public List getList(String queryId, Map args) throws SQLException {
		return super.getList(queryId, args);
	}
	
	public Map getObjectMap(String queryId, Map args) throws SQLException {
		return getMap(queryId, args);
	}
	
	public List<Map> getObjectMapRow(String queryId, Map args) throws SQLException {
		return getList(queryId, args);
	}
	
	public String getXmlData(String queryId, Map args) throws SQLException {
		return getXml(queryId, args);
	}
	
	public Object getObjectString(String queryId, Map args) throws SQLException {
		return getValue(queryId, args);
	}
	
	public List getFileList(String queryId, Map args) throws SQLException {
		return super.getList(queryId, args);
	}
	
	public Map getFile(String queryId, Map args) throws SQLException {
		return getMap(queryId, args);
	}

	public Map getAccessInfo(String queryId, Map args) throws SQLException {
		return getMap(queryId, args);
	}
	
	public int insertData(String queryId, Map args) throws SQLException {
		return (int) regist( queryId,  args);
	}

	@Override
	public String insertScrapFolder(String queryId, Map<String, Object> result) throws SQLException {
		
		return (String) regist(queryId, result);
	}

	@Override
	public List<Map<String, Object>> getFolderList(String queryId,Map<String, Object> paramMap) throws SQLException {
		return getList(queryId, paramMap);
	}
//
//	@Override
//	public List<Map<String, Object>> getFolderList(Map<String, Object> paramMap) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public void insertScrap(String queryId, Map<String, Object> paramMap) throws SQLException  {
		
			regist(queryId, paramMap);
			
		}

	@Override
	public int getScrapCount(String queryId, Map args) throws SQLException {
			return getCount(queryId, args);
	}




}


	

	/*@Override
	// 전문가 PDF 하나 생성
	public File generateExpertPDFFile(Map expert) throws Exception {
	    String name = (String) expert.get("EXPRT_NM");
	    String fileName = "expert_" + name + "_" + System.currentTimeMillis() + ".pdf";
	    File file = File.createTempFile(fileName, null);

	    Document doc = new Document(PageSize.A4);
	    PdfWriter.getInstance(doc, new FileOutputStream(file));
	    doc.open();

	    Font font = FontFactory.getFont(FontFactory.HELVETICA, 12);

	    doc.add(new Paragraph("이름: " + name, font));
	    doc.add(new Paragraph("성별: " + expert.get("EXPRT_GNDR"), font));
	    doc.add(new Paragraph("소속: " + expert.get("OGDP_NM"), font));
	    doc.add(new Paragraph("직책: " + expert.get("JBPS_NM"), font));
	    // ... 필요 항목 추가

	    doc.close();
	    return file;
	}
	// ZIP으로 묶기
	public File makeExpertZipFile(List<File> pdfFiles) throws Exception {
	    File zipFile = File.createTempFile("expert_data_", ".zip");

	    ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipFile));

	    for (File pdf : pdfFiles) {
	        FileInputStream fis = new FileInputStream(pdf);
	        ZipEntry entry = new ZipEntry(pdf.getName());
	        zos.putNextEntry(entry);

	        byte[] buffer = new byte[1024];
	        int len;
	        while ((len = fis.read(buffer)) > 0) {
	            zos.write(buffer, 0, len);
	        }

	        zos.closeEntry();
	        fis.close();
	    }

	    zos.close();
	    return zipFile;
	}*/

