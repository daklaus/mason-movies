<%class>
	has 'docid';
  has 'title';
  has 'content' => (default => "Bitte hier den Text eingeben.");
  has 'metatext';
  has 'Save';
  has 'insert' => (default => 0);
  has 'parentid';
</%class>

<h2>
% if (defined($.docid) && ($.insert==0)) {
Film <% $.docid %> editieren
% } else {
Neuen Film anlegen
% }
</h2>
% if (length($msg)) {
<p style="color:red;font-size:10px;"><% $msg %></p>
% }
<form name="editform"
method="post" enctype="application/x-www-form-urlencoded">

<input type="hidden" name="docid" value="<% $.docid %>">
<input type="hidden" name="insert" value="<% $.insert %>">

<TABLE WIDTH="100%" CELLSPACING=1 CELLPADDING=4 BORDER=0>
<COLGROUP>
<COL ALIGN="right" VALIGN="top">
<COL ALIGN="left">
</COLGROUP>
<TR>
<TD>Titel:</TD>
<TD><input type="text" name="title" value="<% $.title %>" size="50" /></TD> <!-- Filter |h ?? -->
</TR>

<TR>
<TD>Genre-ID:</TD>
<TD>
<%doc>
<%  $cgi->popup_menu(-name      =>'parentid',
                       -values    => [ sort keys %docTitleAndIds ],
                       -default   => $parentid,
                       -labels    => \%docTitleAndIds)
  %> aktuell: <% $docTitleAndIds{$parentid} %>
</%doc>
  <input type="text" name="parentid" value="<% $.parentid %>" size="3" />

</TD>
</TR>
<TR>
<TD ALIGN=left COLSPAN=2>
  <textarea name="content" id="content"><% $.content %></textarea>
<%doc>
<script>
	// Replace the <textarea id="content"> with a CKEditor
	// instance, using default configuration.
	CKEDITOR.replace('content',{
		width   : '560px',
		height  : '400px'
	});
</script>
</%doc>
<BR>
</TD>
</TR>

<TR>
<TD COLSPAN=2 ALIGN=center>
<BR>
<input type="submit" value="&Auml;nderungen speichern" name="Save">
&nbsp;&nbsp;&nbsp;
<input type="reset" value="&Auml;nderungen verwerfen" name="Cancel"> <!-- onClick="window.close()" -->
<BR>
<BR>
</TD>
</TR>
</TABLE>

</form>

<%init>
use Data::Dumper;

my $dbh = Ws18::DBI->dbh();

my $msg = "Welcome to the WCM content editor.";
my %docTitleAndIds = ('0', 'top level document');

my $sth = $dbh->prepare("SELECT id, name from wae10_genre");
$sth->execute();
while (my $res = $sth->fetchrow_hashref()) {
  $docTitleAndIds{$res->{id}} = $res->{name};
}

if ($.Save) {
# Speichern wurde gedr�ckt...
  if ($.insert == 1) {
  # Datensatz aus Formularfeldern in Datenbank einf�gen
    my $sth = $dbh->prepare("INSERT INTO wae10_movie (id, name, description, genre_id, type, rating, image, year) values (?,?,?,?,?,?,?,?)");
    $sth->execute($.docid,$.title,$.content,$.parentid,"MOVIE",undef,undef,"2019");
    $msg = "Datensatz ". $.docid ." neu in DB aufgenommen.".$sth->rows();
    $.insert(0);
  } else {
  # Datensatz in Datenbank �ndern
    my $sth = $dbh->prepare("UPDATE wae10_movie SET description = ?, name = ?, genre_id = ?, type = ?, rating = ?, image = ?, year = ? WHERE id = ?");
    $sth->execute($.content,$.title,$.parentid,"MOVIE",undef,undef,"2019",$.docid);
    $msg = "Datensatz " . $.docid ." in DB ver&auml;ndert.".$sth->rows();
  }
} elsif ($.docid) {
# id erkannt, daten aus Datenbank lesen
  my $sth = $dbh->prepare("SELECT id, name, description, genre_id, type, rating, image, year from wae10_movie WHERE id = ?");
  $sth->execute($.docid);
  my $res = $sth->fetchrow_hashref();
  $.content($res->{description} || $.content);
  $.title($res->{name});
  $.parentid($res->{genre_id});
  $msg = "Datensatz " . $.docid . " aus DB gelesen.".((defined($res) && scalar(keys(%$res)))?1:0);
} else {
# keine ID, neuen Film erstellen
  my $sth = $dbh->prepare("SELECT max(id) as maxdocid FROM wae10_movie");
  $sth->execute();
  my $res = $sth->fetchrow_hashref();
  $.docid($res->{maxdocid}+1);
  $.insert(1);
}
</%init>
