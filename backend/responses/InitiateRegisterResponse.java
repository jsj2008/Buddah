package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class InitiateRegisterResponse
{
    private String instructionMessage;
    private boolean cellphoneTaken;
    
    public InitiateRegisterResponse()
    {
    }

    public String getInstructionMessage()
    {
        return instructionMessage;
    }

    public void setInstructionMessage( String instructionMessage )
    {
        this.instructionMessage = instructionMessage;
    }

    public boolean isCellphoneTaken()
    {
        return cellphoneTaken;
    }

    public void setCellphoneTaken( boolean cellphoneTaken )
    {
        this.cellphoneTaken = cellphoneTaken;
    }   
    
}
