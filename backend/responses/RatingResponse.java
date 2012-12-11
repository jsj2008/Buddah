package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class RatingResponse
{
    private float averageRating;
    private ArrayList<String> commentaryList;
    
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

    public ArrayList<String> getCommentaryList()
    {
        return commentaryList;
    }

    public void setCommentaryList( ArrayList<String> commentaryList )
    {
        this.commentaryList = commentaryList;
    }
    
}
