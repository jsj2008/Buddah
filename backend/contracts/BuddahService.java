package services.contracts;

import java.net.HttpURLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.*;
import javax.xml.bind.JAXBElement;

import com.google.gson.Gson;

import constants.LoggingConstants;
import constants.QueueConstants;

import logging.Logger;

import services.requests.*;
import services.worker.AccountWorkProcessor;
import services.worker.PostingWorkProcessor;
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
    //
    // Account Service Endpoints
    //

    @OPTIONS
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response initiateRegisterPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "initiateRegisterPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @PUT
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response initiateRegister( @Context HttpServletRequest req, InitiateRegisterRequest initiateRegisterRequest )
    {
        Logger.logRequest( req, "initiateRegister", initiateRegisterRequest, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.initiateRegisterProcessor( initiateRegisterRequest );
    }

    @OPTIONS
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response confirmRegisterPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "confirmRegisterPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response confirmRegister( @Context HttpServletRequest req, ConfirmRegisterRequest confirmRegisterRequest )
    {
        Logger.logRequest( req, "confirmRegister", confirmRegisterRequest, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.confirmRegisterProcessor( confirmRegisterRequest );
    }

    @OPTIONS
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response loginPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "loginPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response login( @Context HttpServletRequest req, LoginRequest loginRequest )
    {
        Logger.logRequest( req, "login", loginRequest, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.loginProcessor( loginRequest );
    }

    @OPTIONS
    @Path( "getUserInfo" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getUserInfo( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getUserInfoPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }
    
    @POST
    @Path( "getUserInfo" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getUserInfo( @Context HttpServletRequest req, GetUserInfoRequest getUserInfoRequest )
    {
        Logger.logRequest( req, "getUserInfo", getUserInfoRequest, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.getUserInfoProcessor( getUserInfoRequest );
    }    
    
    @OPTIONS
    @Path( "getUserInfoResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getUserInfoResultPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getUserInfoResultPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }
    
    @POST
    @Path( "getUserInfoResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getUserInfoResult( @Context HttpServletRequest req, GetUserInfoResultRequest getUserInfoResultRequest )
    {
        Logger.logRequest( req, "getUserInfoResult", getUserInfoResultRequest, LoggingConstants.VERBOSE );

        return AccountWorkProcessor.getUserInfoResultProcessor( getUserInfoResultRequest );
    } 

    //
    // Posting Service Endpoints
    //

    @OPTIONS
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getDealsPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDeals( @Context HttpServletRequest req, GetDealsRequest getDealsRequest )
    {
        Logger.logRequest( req, "getDeals", getDealsRequest, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.getDealsProcessor( getDealsRequest );
    }

    @OPTIONS
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response getDealsResultPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "getDealsResultPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "getDealsResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response getDealsResult( @Context HttpServletRequest req, GetDealsResultRequest getDealsResultRequest )
    {
        Logger.logRequest( req, "getDealsResult", getDealsResultRequest, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.getDealsResultProcessor( getDealsResultRequest );
    }

    @OPTIONS
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response ratingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "ratingPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response rating( @Context HttpServletRequest req, RatingRequest ratingRequest )
    {
        Logger.logRequest( req, "rating", ratingRequest, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.ratingProcessor( ratingRequest );
    }

    @OPTIONS
    @Path( "posting" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response postingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "postingPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @PUT
    @Path( "posting" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response posting( @Context HttpServletRequest req, PostingRequest postingRequest )
    {
        Logger.logRequest( req, "posting", postingRequest, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.postingProcessor( postingRequest );
    }

    @OPTIONS
    @Path( "viewUserRating" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewUserRatingPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "viewUserRatingPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "viewUserRating" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewUserRating( @Context HttpServletRequest req, ViewUserRatingRequest viewUserRatingRequest )
    {
        Logger.logRequest( req, "viewUserRating", viewUserRatingRequest, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.viewUserRatingProcessor( viewUserRatingRequest );
    }

    @OPTIONS
    @Path( "viewUserRatingResult" )
    @Consumes( { MediaType.APPLICATION_OCTET_STREAM } )
    @Produces( { MediaType.APPLICATION_OCTET_STREAM } )
    public Response viewUserRatingResultPreflight( @Context HttpServletRequest req )
    {
        Logger.logRequest( req, "viewUserRatingResultPreflight", null, LoggingConstants.NORMAL );

        return ServiceModifiers.wrapHeaders( null, MediaType.APPLICATION_OCTET_STREAM, HttpURLConnection.HTTP_OK );
    }

    @POST
    @Path( "viewUserRatingResult" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public Response viewUserRatingResult( @Context HttpServletRequest req,
            ViewUserRatingResultRequest viewUserRatingResultRequest )
    {
        Logger.logRequest( req, "viewUserRatingResult", viewUserRatingResultRequest, LoggingConstants.VERBOSE );

        return PostingWorkProcessor.viewUserRatingResultProcessor( viewUserRatingResultRequest );
    }

}
