package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Feedback;

@XmlRootElement
public class ViewPostResponse
{
    String guid;

    public ViewPostResponse()
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
