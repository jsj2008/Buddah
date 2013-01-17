package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class GetDealsResultRequest
{
    String guid;
    
    public GetDealsResultRequest()
    {
        // TODO Auto-generated constructor stub
    }    

    public String getGuid()
    {
        return guid;
    }

    public void setGuid( String guid )
    {
        this.guid = guid;
    }

}
