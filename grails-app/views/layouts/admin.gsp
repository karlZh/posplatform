<%@ page import="posscard.User" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
	<meta name="layout" content="main">
	<title></title>
	<!-- Bootstrap core CSS -->
	<link href="${resource(dir: 'js/bootstrap/dist/css', file: 'bootstrap.css')}" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery.gritter/css', file: 'jquery.gritter.css')}" />

	<link rel="stylesheet" href="${resource(dir: 'fonts/font-awesome-4/css', file: 'font-awesome.min.css')}">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		      <script src="https\oss.maxcdn.com\libs\html5shiv\3.7.0\MS_4.js"></script>
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery.nanoscroller',file: 'nanoscroller.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery.easypiechart',file: 'jquery.easy-pie-chart.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/bootstrap.switch',file: 'bootstrap-switch.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/bootstrap.datetimepicker/css',file: 'bootstrap-datetimepicker.min.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery.select2',file: 'select2.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/bootstrap.slider/css',file: 'slider.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery.datatables/bootstrap-adapter/css',file: 'datatables.css')}" />
	<link href="${resource(dir: 'css',file: 'style.css')}" rel="stylesheet" />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
    <g:layoutHead/>
</head>
	<body>
		<g:render template="/common/head-nav" />
		<div id="cl-wrapper">

        <g:if test="${User.get(session.user_id)?.accountType} == 2"><!-- 自己平台-->
            <g:render template="/common/sidebar1" />
        </g:if>
        <g:elseif test="${User.get(session.user_id)?.accountType} == 3"><!-- 商户-->
            <g:render template="/common/sidebar2" />
        </g:elseif>
        <g:elseif test="${User.get(session.user_id)?.accountType} == 4"><!-- 供应商-->
            <g:render template="/common/sidebar3" />
        </g:elseif>
		<g:layoutBody/>
		</div>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.nanoscroller', file: 'jquery.nanoscroller.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.sparkline', file: 'jquery.sparkline.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.easypiechart', file: 'jquery.easy-pie-chart.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/behaviour', file: 'general.js')}"></script>
	<script src="${resource(dir: 'js/jquery.ui', file: 'jquery-ui.js')}" type="text/javascript"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.nestable', file: 'jquery.nestable.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/bootstrap.switch', file: 'bootstrap-switch.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/bootstrap.datetimepicker/js', file: 'bootstrap-datetimepicker.min.js')}"></script>
	<script src="${resource(dir: 'js/jquery.select2', file: 'select2.min.js')}" type="text/javascript"></script>
	<script src="${resource(dir: 'js/bootstrap.slider/js', file: 'bootstrap-slider.js')}" type="text/javascript"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.gritter/js', file: 'jquery.gritter.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.datatables', file: 'jquery.datatables.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.datatables/bootstrap-adapter/js', file: 'datatables.js')}"></script>
	<script type="text/javascript">
        //Add dataTable Functions
        var functions = $('<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Actions</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="#">Edit</a></li><li><a href="#">Copy</a></li><li><a href="#">Details</a></li><li class="divider"></li><li><a href="#">Remove</a></li></ul></div>');
        $("#datatable tbody tr td:last-child").each(function(){
            $(this).html("");
            functions.clone().appendTo(this);
        });

        //Add dataTable Icons
        var functions = $('<a class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip"><i class="fa fa-file"></i></a> <a class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip"><i class="fa fa-pencil"></i></a> <a class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip"><i class="fa fa-times"></i></a>');
        $("#datatable-icons tbody tr td:last-child").each(function(){
            $(this).html("");
            functions.clone().appendTo(this);
        });

        $(document).ready(function(){
            //initialize the javascript
            App.init();
            App.dataTables();

            /* Formating function for row details */
            function fnFormatDetails ( oTable, nTr )
            {
                var aData = oTable.fnGetData( nTr );
                var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
                sOut += '<tr><td>Rendering engine:</td><td>'+aData[1]+' '+aData[4]+'</td></tr>';
                sOut += '<tr><td>Link to source:</td><td>Could provide a link here</td></tr>';
                sOut += '<tr><td>Extra info:</td><td>And any further details here (images etc)</td></tr>';
                sOut += '</table>';

                return sOut;
            }

            /*
             * Insert a 'details' column to the table
             */
            var nCloneTh = document.createElement( 'th' );
            var nCloneTd = document.createElement( 'td' );
            nCloneTd.innerHTML = '<img class="toggle-details" src="images\plus.png" />';
            nCloneTd.className = "center";

            $('#datatable2 thead tr').each( function () {
                this.insertBefore( nCloneTh, this.childNodes[0] );
            } );

            $('#datatable2 tbody tr').each( function () {
                this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
            } );

            /*
             * Initialse DataTables, with no sorting on the 'details' column
             */
            var oTable = $('#datatable2').dataTable( {
                "aoColumnDefs": [
                    { "bSortable": false, "aTargets": [ 0 ] }
                ],
                "aaSorting": [[1, 'asc']]
            });

            /* Add event listener for opening and closing details
             * Note that the indicator for showing which row is open is not controlled by DataTables,
             * rather it is done here
             */
            $('#datatable2').delegate('tbody td img','click', function () {
                var nTr = $(this).parents('tr')[0];
                if ( oTable.fnIsOpen(nTr) )
                {
                    /* This row is already open - close it */
                    this.src = "images\plus.png";
                    oTable.fnClose( nTr );
                }
                else
                {
                    /* Open this row */
                    this.src = "images\minus.png";
                    oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
                }
            } );

            $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
            $('.dataTables_length select').addClass('form-control');

            //Horizontal Icons dataTable
            $('#datatable-icons').dataTable();
        });
	</script>
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${resource(dir: 'js/behaviour', file: 'voice-commands.js')}"></script>
	<script src="${resource(dir: 'js/bootstrap/dist/js', file: 'bootstrap.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.flot', file: 'jquery.flot.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.flot', file: 'jquery.flot.pie.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.flot', file: 'jquery.flot.resize.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js/jquery.flot', file: 'jquery.flot.labels.js')}"></script>
	</body>
</html>
