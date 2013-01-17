package services.contracts;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.*;
import javax.xml.bind.JAXBElement;

import com.google.gson.Gson;

import constants.QueueConstants;

import logging.Logger;

import services.queue.*;
import services.requests.*;
import services.responses.*;
import utilities.services.ServiceModifiers;

// Service endpoint will be base url 'http://buddah.herokuapp.com/' followed by the @Path for the service and a specific endpoint,
// ex initiateRegister url = 'http://buddah.herokuapp.com/services/initiateRegister'
// 
// All service endpoints come in pairs to deal with cross site scripting (there's probably a better way, but for now this is it)
//
// @OPTIONS endpoints are for browser pre-flight requests
// @PUT, POST, GET, DELETE corresponding pairs are real requests that are made after pre-flights or directly

@Path( "/services" )
@Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN } )
public class BuddahService
{
    private final static String ACCOUNT_QUEUE = QueueConstants.ACCOUNT_QUEUE;
    private final static String POSTING_QUEUE = QueueConstants.POSTING_QUEUE;

    private static Gson gson = new Gson();

    @OPTIONS
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response initiateRegisterPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "initiateRegisterPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @PUT
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public Response initiateRegister( @Context HttpServletRequest req, InitiateRegisterRequest initiateRegisterRequest )
    {
        Logger.logRequest( req, "initiateRegister" );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, "initiateRegister".getBytes() );
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, gson.toJson( initiateRegisterRequest ).getBytes() );

        InitiateRegisterResponse response = new InitiateRegisterResponse();
        response.setInstructionMessage( "Please wait for a text to arrive at your number." );

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response confirmRegisterPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "confirmRegisterPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public Response confirmRegister( @Context HttpServletRequest req, ConfirmRegisterRequest confirmRegisterRequest )
    {
        Logger.logRequest( req, "confirmRegister" );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, "confirmRegister".getBytes() );
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, gson.toJson( confirmRegisterRequest ).getBytes() );

        ConfirmRegisterResponse response = new ConfirmRegisterResponse();
        response.setToken( "ABCD-EFGH-IJKL-MNOP-QRST-UVWX-YZ" );

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response loginPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "loginPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public Response login( @Context HttpServletRequest req, LoginRequest loginRequest )
    {
        Logger.logRequest( req, "login" );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, "login".getBytes() );
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, gson.toJson( loginRequest ).getBytes() );

        LoginResponse response = new LoginResponse();
        response.setResult( true );

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getDealsPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDeals( @Context HttpServletRequest req, GetDealsRequest getDealsRequest )
    {
        Logger.logRequest( req, "getDeals" );

        // TODO verify token in http header

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "getDeals".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( getDealsRequest ).getBytes() );

        GetDealsResponse response = new GetDealsResponse();

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsResultPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getDealsResultPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDealsResult( @Context HttpServletRequest req, GetDealsResultRequest getDealsResultRequest )
    {
        Logger.logRequest( req, "getDealsResult" );

        // TODO verify token in http header

        // TODO Redis retrieval

        GetDealsResultResponse response = new GetDealsResultResponse();

        // TODO set additional header for whether result is in cache (to
        // differentiate no result with null result)
        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_OCTET_STREAM );
    }

    @OPTIONS
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response ratingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "ratingPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response rating( @Context HttpServletRequest req, RatingRequest ratingRequest )
    {
        Logger.logRequest( req, "rating" );

        // TODO verify token in http header

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "rating".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( ratingRequest ).getBytes() );

        RatingResponse response = new RatingResponse();

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "posting" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response postingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "postingPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @PUT
    @Path( "posting" )
    public Response posting( @Context HttpServletRequest req, PostingRequest postingRequest )
    {
        Logger.logRequest( req, "posting" );

        // TODO verify token in http header

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "posting".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( postingRequest ).getBytes() );

        PostingResponse response = new PostingResponse();
        response.setTimeLeft( postingRequest.getListing().getStartTime() - Calendar.getInstance().getTimeInMillis() );

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "viewPost" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewPostPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "viewPostPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "viewPost" )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewPost( @Context HttpServletRequest req, ViewPostRequest viewPostRequest )
    {
        Logger.logRequest( req, "viewPost" );

        // TODO verify token in http header

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "viewPost".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( viewPostRequest ).getBytes() );

        ViewPostResponse response = new ViewPostResponse();

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

    @OPTIONS
    @Path( "viewPostResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewPostResultPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "viewPostResultPreflight" );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM );
    }

    @POST
    @Path( "viewPostResult" )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewPostResult( @Context HttpServletRequest req, ViewPostResultRequest viewPostResultRequest )
    {
        Logger.logRequest( req, "viewPostResult" );

        // TODO verify token in http header

        // TODO Redis retrieval

        ViewPostResultResponse response = new ViewPostResultResponse();

        return ServiceModifiers.wrapHeaders( response, MediaType.APPLICATION_JSON );
    }

}
