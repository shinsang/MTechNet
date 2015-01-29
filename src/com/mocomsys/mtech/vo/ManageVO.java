/**
 *
 */
package com.mocomsys.mtech.vo;

/**
 * @author YungKi(used manageProcess)
 *
 */
public class ManageVO
{

	String tagName;
	String tagInsertDate;
	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	String count;
	
	public ManageVO(String tagName, String count) {
		setTagName(tagName);
		setCount(count);
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public String getTagInsertDate() {
		return tagInsertDate;
	}

	public void setTagInsertDate(String tagInsertDate) {
		this.tagInsertDate = tagInsertDate;
	}

	public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append("[ MTechNet String  ]");

    	return sb.toString();
    }
}
