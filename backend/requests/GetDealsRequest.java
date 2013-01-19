package services.requests;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Position;

@XmlRootElement
public class GetDealsRequest
{
    private String userToken;
    private String username;
    private double yOffset;
    private double xOffset;
    private Position position;

    public GetDealsRequest()
    {
    }


    public String getUserToken()
    {
        return userToken;
    }

    public void setUserToken( String userToken )
    {
        this.userToken = userToken;
    }    
    
    public String getUsername()
    {
        return username;
    }

    public void setUsername( String username )
    {
        this.username = username;
    }
    
    public Position getPosition()
    {
        return position;
    }

    public void setPosition( Position position )
    {
        this.position = position;
    }

    public double getyOffset()
    {
        return yOffset;
    }

    public void setyOffset( double yOffset )
    {
        this.yOffset = yOffset;
    }

    public double getxOffset()
    {
        return xOffset;
    }

    public void setxOffset( double xOffset )
    {
        this.xOffset = xOffset;
    }
    
}
