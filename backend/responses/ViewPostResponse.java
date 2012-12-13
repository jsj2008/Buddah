package services.responses;

import java.util.ArrayList;

import model.services.Feedback;

public class ViewPostResponse
{
    ArrayList<Feedback> feedbackList;
    
    public ViewPostResponse()
    {
    }

    public ArrayList<Feedback> getFeedbackList()
    {
        return feedbackList;
    }

    public void setFeedbackList( ArrayList<Feedback> feedbackList )
    {
        this.feedbackList = feedbackList;
    }

}
