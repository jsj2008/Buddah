package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class GetUserInfoResponse
{
    String guid;

    public GetUserInfoResponse()
    {
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

