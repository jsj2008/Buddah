package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class RatingResponse
{
    private float averageRating;
    private int numRatings;
    
    public RatingResponse()
    {
    }

    public float getAverageRating()
    {
        return averageRating;
    }

    public void setAverageRating( float averageRating )
    {
        this.averageRating = averageRating;
    }

    public int getNumRatings()
    {
        return numRatings;
    }

    public void setNumRatings( int numRatings )
    {
        this.numRatings = numRatings;
    }
    
}
