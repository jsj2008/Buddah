package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

import model.Position;

@XmlRootElement
public class GetDealsRequest
{
    private String userId;
    private Position position;

    public GetDealsRequest()
    {
    }

    public Position getPosition()
    {
        return position;
    }

    public void setPosition( Position position )
    {
        this.position = position;
    }

    public String getUserId()
    {
        return userId;
    }

    public void setUserId( String userId )
    {
        this.userId = userId;
    }
    
}
