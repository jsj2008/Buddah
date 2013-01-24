package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class GetUserInfoResultResponse
{    
    String usernameDealer;
    int numPosts;
    int numRatings;
    double avgRating;

    public GetUserInfoResultResponse()
    {
        // TODO Auto-generated constructor stub
    }

    public String getUsernameDealer()
    {
        return usernameDealer;
    }

    public void setUsernameDealer( String usernameDealer )
    {
        this.usernameDealer = usernameDealer;
    }

    public int getNumPosts()
    {
        return numPosts;
    }

    public void setNumPosts( int numPosts )
    {
        this.numPosts = numPosts;
    }

    public int getNumRatings()
    {
        return numRatings;
    }

    public void setNumRatings( int numRatings )
    {
        this.numRatings = numRatings;
    }

    public double getAvgRating()
    {
        return avgRating;
    }

    public void setAvgRating( double avgRating )
    {
        this.avgRating = avgRating;
    }

}
