package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class InitiateRegisterRequest
{
    private String cellphone;

    public InitiateRegisterRequest()
    {
    }

    public String getCellphone()
    {
        return cellphone;
    }

    public void setCellphone( String cellphone )
    {
        this.cellphone = cellphone;
    }
    
    public String toString()
    {
        return "cellphone: " + cellphone;
    }

}
