package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Listing;

@XmlRootElement
public class GetDealsResponse
{
    String guid;

    public GetDealsResponse()
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
