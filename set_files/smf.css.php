
@font-face {
  font-family: 'Plantin';
  src: url('../../funcards/smffcmonline/fonts/mplantinb.ttf');
}



body
{
	background:		#1E1D19;
	font-family:	Verdana;
	font-size:		11px;
	padding:		0;
	margin: 		0 0 15 0;	
}

table
{
	font-family:	Verdana;
	font-size:		11px;
	padding:		0;
	margin:			0;
}

#global
{
	width: 				1000px; /* -> 3 */
	overflow: 			hidden; /* -> 3 */
	margin-right:		auto;
	margin-left:		auto;
	background:			#FFFFFF;
	background-image: 	url("../../images/interface/fond_factice.png");
	background-repeat:	repeat-y;	
}

/* En-tête */
#header
{
	text-align:			center;
	height:				187px;
	width:				1000px;	
	background:			#E1D4CC;
	background-image:	url(../../images/interface/B/newHeader2.jpg);
}

#footer
{
	margin:	0;
	clear:	left;	
}

#footerBarre
{	
	margin-bottom:		15px;
	height:				25px;
	width:				1000px;	
	background:			#1E1D19;
	background-image:	url(../../images/interface/B/footer.jpg);
	margin-left:		auto;
	margin-right:		auto;
}

#footerContent
{	
	margin:					0;
	width:					1000px;
	padding:				4 0 4 0 ;
	background:				#FDFEF9;
	margin-left:			auto;
	margin-right:			auto;
	-moz-border-radius:		10px;
	border-radius:			10px;
	-webkit-border-radius:	10px;
	-moz-box-shadow: 		2px 2px 2px #333;
	-webkit-box-shadow:		2px 2px 2px #333;
	box-shadow:				2px 2px 2px #333;	
}

#footerFin
{
	clear:			left;		
	margin:			0;
	height:			26px;
	width:			300px;	
	background:		#E1D4CC;
	/*background-image: url(../../images/interface/B/footer.jpg);*/
	text-align:		center;
	color:			#34312C;
	margin-left:	auto;
	margin-right:	auto;	
}


#content
{
	text-align:		left;
	width:			700px;	
	padding:		10 0 10 0;
	float:			left;
	background:		#FFFFFF;
	line-height:	1.3;	
}

/* Menu de navigation */
#menu
{
	padding:	5 0 0 0;
	width:		300px;
	float:		left;
	background:	#E5E5E5;
	height:		auto;
	font-size:	10px;	
}

#middle
{
	background:			#E5E5E5;
	overflow:			auto ;
	background:			#FFFFFF;
	background-image: 	url("../../images/interface/fond_factice.png");
	background-repeat:	repeat-y;	
}


.conteneurlienhaut
{
	float:		right ;
	padding:	0 15 0 0 ;
  	margin:		0 auto; 
	width:		auto;
}

.titreRight,
.titreBlanc
{
	padding-top:		5px;
	text-align:			left;
	font-size:			11px;
	color:				#636363;
	font-weight:		bold;
	text-decoration:	none;
	display:			block;
}

.titreBlanc
{
	color:	#FFFFFF;
}

a,
a.lienRight
{
	font-size:			11px;
	color:				#000000;
	font-weight:		bold;
	text-decoration:	none;	
}

a.lienLeft
{
	font-size:			14px;
	color:				#000000;
	font-weight:		bold;
	text-decoration:	none;	
}

a:hover
{
	text-decoration:	underline;
}

.index_container
{
	display:				block;
	background-color:		#FFFFFF;
	margin:					10 1 10 1 ;
	text-align:				left;
	-moz-border-radius:		5px;
	-webkit-border-radius:	5px;	
	border-radius:			5px;
	border-bottom:			1px solid #C4C4C4;
	font-weight:			normal;
}

.index_container_left
{
	margin:		10 0 10 0 ;
	text-align:	left;
	width:		400px;
}

.index_container_image
{
	display:	inline;
	float:		left;
	width:		70px;
	align:		center;
}

.index_container_texte,
.index_container_texte_left
{
	padding-left:	10px;
	width:			300px;
	border-left:	1px solid #B9B9B9 ;	
	display:		inline;
	float:			left;
	line-height:	1.3;
}

.index_container_texte_left
{
	width:	170px;
}

.col-int5
{
	padding:	5px;
}

.col-int8
{
	padding:	8px;
}

.col-int3
{
	padding:	3px;
}

.col-int10
{
	padding:	10px;
}

#footerContainer
{
	padding:			3px;
	float:				left;
	/*-moz-transform:		rotate(-1deg);*/
	/*-webkit-transform:	rotate(-1deg);*/	
}

#footerLiensContainer
{
	float:	right;
}

.liensEnBas
{
	display:			block;
	width:				320px;
	font-size:			10px;	
	color:				#34312C;
	border-bottom:		1px dashed #34312C;
	padding:			5px;	
	text-decoration:	none;
	font-weight:		normal;
	text-align:			right;
}

.liensEnBas:hover
{
	text-decoration:	none;
	color:				#BE0000;	
}

.index_container_line
{
	margin-top:		10px;
	padding:		1px;
	border-top:		1px dashed #B9B9B9 ;
	border-bottom:	1px dashed #B9B9B9 ;	
	display:		block;
	width:			380px;
}

.index_item, .index_item_dernier
{
	margin-right:	5px;
	padding-right:	5px;
	border-right:	1px solid #B9B9B9 ;
	font-size:		10px;
	width:			84px;
	text-align:		center;
	float:			left;
}

.index_item_dernier
{
	border-right:0px;
}

/*** Organisation générale ***/
td
{
	font-family:	Verdana;
	font-size:		11px;
}

h1
{
	font-family:	Plantin,Verdana;
	font-weight:	normal;
	font-size:		22px;
	color:			#34312C;
	padding:		0px;
	margin:			5 0 15 0;
}

.homeTitle
{
	font-family:	Plantin,Verdana;
	font-weight:	normal;
	font-size:		15px;
	color:			#34312C;
	padding:		0px;
	margin:			8 0 8 0;
}

.menuTitle
{
	text-align:		center;
	font-family:	Verdana;
	font-weight:	bold;
	font-size:		12px;
	color:			#000000;	
}

ul#tags
{
	margin:			3px;
	margin-top:		7px;
	padding-left:	15px;	
}

ul#tags li
{
	float:								left;
	margin-right:						20px;	
	padding:							1px;
	padding-right:						10px;	
	padding-left:						10px;	
	width:								auto;
	font-weight:						normal;
	text-decoration:					none;
	color:								#E1D4CC;
	background-color:					#FFFFFF;
	-moz-border-radius:					3px;
	-webkit-border-radius:				3px;
	border-radius:						3px;
	-moz-border-radius-bottomleft:		15px;
	-moz-border-radius-topleft:			15px;
	border-radius-bottomleft:			15px;
	-webkit-border-bottom-left-radius:	15px;
	-webkit-border-top-left-radius:		15px;
	border-top-left-radius:				15px;
	list-style-type:					disc;
	list-style-position:				inside;	
}

ul#tags li a
{
	font-size:			10px;
	font-weight:		normal;
	text-decoration:	none;
	color:				#000000;
	font-size:			10px;	
}

ul#tags li a:hover
{
	font-size:			10px;
	font-weight:		normal;
	text-decoration:	none;
	color:				#000000;
	font-size:			10px;
}

.tags{
	margin:10 0 0 0;
	padding:0;
	float:left;
	list-style:none;
	}	
.tags li, .tags a{
	float:left;
	height:20px;
	line-height:20px;
	position:relative;
	font-size:10px;
	margin-bottom:2px;
	}	
.tags a{
	margin-left:20px;
	padding:0 10px 0 12px;
	background:#34312C;
	color:#fff;
	text-decoration:none;
	-moz-border-radius-bottomright:4px;
	-webkit-border-bottom-right-radius:4px;	
	border-bottom-right-radius:4px;
	-moz-border-radius-topright:4px;
	-webkit-border-top-right-radius:4px;	
	border-top-right-radius:4px;	
	}	
.tags a:before{
	content:"";
	float:left;
	position:absolute;
	top:0;
	left:-12px;
	width:0;
	height:0;
	border-color:transparent #34312C transparent transparent;
	border-style:solid;
	border-width:10px 12px 10px 0;		
	}	
.tags a:after{
	content:"";
	position:absolute;
	top:8px;
	left:0;
	float:left;
	width:4px;
	height:4px;
	-moz-border-radius:2px;
	-webkit-border-radius:2px;
	border-radius:2px;
	background:#fff;
	-moz-box-shadow:-1px -1px 2px #004977;
	-webkit-box-shadow:-1px -1px 2px #004977;
	box-shadow:-1px -1px 2px #004977;
	}		

.tags a:hover{background:#E1D4CC;}	
.tags a:hover:before{border-color:transparent #E1D4CC transparent transparent;}


.calendar{
	margin:.25em 10px 0px 0;
	padding-top:5px;
	width:70px;
	background:#ededef;
	background: -webkit-gradient(linear, left top, left bottom, from(#ededef), to(#ccc)); 
	background: -moz-linear-gradient(top,  #ededef,  #ccc); 
	font:bold 20px/30px Verdana, Arial Black, Arial, Helvetica, sans-serif;
	text-align:center;
	color:#000;
	text-shadow:#fff 0 1px 0;	
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;	
	//position:relative;
	-moz-box-shadow:0 2px 2px #888;
	-webkit-box-shadow:0 2px 2px #888;
	box-shadow:0 2px 2px #888;
	}
.calendar em{
	display:block;
	font:normal bold 11px/14px Verdana, Arial, Helvetica, sans-serif;
	color:#fff;
	text-shadow:#00365a 0 -1px 0;	
	background:#34312C;
	background:-webkit-gradient(linear, left top, left bottom, from(#1E1D19), to(#34312C)); 
	background:-moz-linear-gradient(top,  #1E1D19,  #34312C); 
	-moz-border-radius-bottomright:3px;
	-webkit-border-bottom-right-radius:3px;	
	border-bottom-right-radius:3px;
	-moz-border-radius-bottomleft:3px;
	-webkit-border-bottom-left-radius:3px;	
	border-bottom-left-radius:3px;	
	border-top:1px solid #00365a;
	}	
		

/************ Citations ******/
.citation,
.retour_success,
.retour_error
{
	font-size:				11px; color: #000;
	background-color:		#E1D4CC;
	text-align:				left;
	background-repeat:		no-repeat;
	background-position:	top left;
	background-image:		url('../../images/guillemet.png');			
	text-align:				left;
	padding:				6px;
	padding-left:			30px;	
	width:					90%;
	max-width:				90%;
	display:				block;
	margin-left:			auto;
	margin-right:			auto;
	-moz-border-radius: 	5px;
	-webkit-border-radius: 	5px;
	border-radius: 			5px;	
}

.citation
{
	border:	1px solid #fff;
}

.retour_error,
.retour_success
{
	padding:				15px 10px 15px 50px;
	margin-bottom:			10px;	
	background-position:	10px center;	
	background-image:		url('../../images/error_2.png');
	color:					#D8000C;
	font-weight:			bold;	
	background-color:		#EFC0A4;
}

.retour_success
{
	background-image:	url('../../images/success_2.png');
	color:				#4F8A10;
	background-color:	#E3ECDB;
}

h2
{
	display:			block;
	background-color:	;
	width:				100%;
	font-family:		verdana ;
	font-size:			11px;	
	font-weight:		bold;
	color:				#000000;
	padding:			3px;
	margin-bottom:		0px;	
}

/**** Résumé des articles ****/
.bord_rond
{
	background-color:		#EFE8E4;
	margin:					10px;
	display:				block;
	text-align:				left;
	padding:				5px;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;	
}


.userCardPair, .userCardImpair
{
	background-color:		#E1D4CC;
	margin:					5px;
	float:				left;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;
	width:210px;
	text-align:left;
}

.userCardImpair
{
	background-color:		#EFE8E4;
}

.abstract,
.abstract2
{
	background-color:		#EFE8E4;
	margin:					10px;
	display:				block;
	text-align:				left;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;	
}

.abstract .auteur,
.abstract2 .auteur
{
	padding-left:	5px;
	float:			right;
}

.abstract .auteur ul,
.abstract2 .auteur ul
{
	color:			#34312C;
	border-left:	1px solid #34312C ;
	padding-left:	5px;
	padding-right:	5px;
	margin:			auto;
}

.abstract .auteur li,
.abstract2 .auteur li
{
	font-family:		Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size:			10px;
	border-bottom:		1px dotted #34312C ;
	list-style:			none;
	color:				#000000;
	background-color:	transparent;
	margin:				2px 2px 2px 2px;
	padding:			2px;
}

.abstract .auteur li.dernier,
.abstract2 .auteur li.dernier
{
	border-bottom:	0;
}

.abstract .auteur strong,
.abstract2 .auteur strong
{
	background-color:	transparent;
	color:				#34312C;
}

.abstract2
{
	background-color:	#E1D4CC;
}

.abstract2 .auteur ul
{
	color:			#34312C;
	border-left:	1px solid #34312C ;
}

.abstract2 .auteur li
{
	border-bottom:	1px dotted #34312C ;
}

.abstract2 .auteur li.dernier
{
	border-bottom:	0;
}

.abstract2 .auteur strong
{
	color:	#34312C;
}

.clear
{
	clear:		both;
	padding:	0px;
	margin:		0;
	text-align:	left;
}

/************** commentaires *****************/
.cadre_fonce
{
	background-color:		#E1D4CC ;
	background-repeat:		no-repeat;
	background-position:	top right;
	background-image:		url('../../images/font_comment.png');			
	text-align:				left;
	padding:				8px;
	position:				relative;
	width:					90%;
	display:				block;
	margin-left:			auto;
	margin-right:			auto;
	-moz-border-radius:		10px;
	border-radius:			10px;
	-webkit-border-radius:	10px;
}

.bouton_envoyer,
.bouton_envoyer:hover,
.bouton_connexion,
.bouton_connexion:hover,
.bouton_preview,
.bouton_preview:hover
{
	background-color:		#FFFFFF;
	background-repeat:		no-repeat;
	background-position:	8px center;
	background-image:		url('../../images/success.png');			
	text-align:				left;
	padding:				8px 8px 8px 37px;
	margin:					0;
	font-size:				12px;
	font-weight:			bold;
	color:					#000000;
	border:					1px solid #b2b2b2;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;		
}

.bouton_envoyer:hover,
.bouton_connexion:hover,
.bouton_preview:hover
{		
	background-color:	#EFE8E4;
	cursor:				pointer;		
}

.bouton_connexion,
.bouton_connexion:hover
{		
	font-size:			11px;
	background-image:	url('../../images/interface/boutonconnexion.png');
	padding:			5px 5px 5px 30px;		
}	

.bouton_preview,
.bouton_preview:hover
{		
	background-image:	url('../../images/soleil.png');
}

.bouton_go
{
	font-size:				11px;
	font-weight:			bold;
	color:					#000000;
	background-color:		#FFFFFF;
	background-repeat:		no-repeat;	
	background-image:		url('../../images/go.png');
	background-position:	5px center;		
	width:					60px;
	padding:				4 4 0 30;
	margin-bottom:			4px;
	border:					1px solid #B2B2B2;
	border-top-color:		#FFFFFF;
	border-left-color:		#FFFFFF;		
}

.bouton_go:hover
{		
	background-color:	#EFE8E4;
	cursor:				pointer;		
}

.cadre_clair
{
	width:					90%;		
	background-color:		#EFE8E4;
	font-family:			Verdana;
	font-size:				11px;
	text-align:				center;
	padding:				3px;
	display:				block;
	margin-left:			auto;
	margin-right:			auto;		
	border-style:			solid;
	border-width:			1px;		
	border-bottom-color:	#B2B2B2;
	border-right-color:		#B2B2B2;		
	border-top-color:		#FFFFFF;
	border-left-color:		#FFFFFF;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;		
}

.cadre_clair2
{
	position:				relative;
	width:					auto;		
	float:					left; 
	background-color:		#EFE8E4;
	font-family:			Verdana;
	font-size:				11px;
	text-align:				center;
	padding:				2px;
	display:				inLine;
	margin:					0;
	margin-left:			15px;		
	border-style:			solid;
	border-width:			1px;		
	border-bottom-color:	#B2B2B2;
	border-right-color:		#B2B2B2;		
	border-top-color:		#FFFFFF;
	border-left-color:		#FFFFFF;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;		
}

.post_comment
{
	position:				relative;
	float:					left; 
	width:					auto;
	font-family:			Verdana;
	font-size:				11px;
	border-bottom-color:	;
	border-width:			1px;
	border-style:			solid;
	border-right-color:		;	
	-moz-border-radius:		5px;
	border-radius:			5px;
	-webkit-border-radius:	5px;
	transition: height 0.2s;-webkit-transition: height 0.2s;-moz-transition: height 0.2s;
}

.louanges
{	
	color:			#000000;
	font-size:		12px;
	font-weight:	bold;
	margin:			10px;
	padding:		3px;
	width:			80%;	
}
/************** fin de commentaires *****************/

/*** autorisations ****/
.autorisationOK,
.autorisationKO,
.autorisationOKKO
{
	font-size:				10px;
	font-weight:			bold;
	width:					25px;
	text-align:				center;
	padding:				2px;
	display:inline;
	background-color:		#AFEAA2;
	color:					green;
	margin-top:				2px;
	border-radius:			10px;
	-moz-border-radius:		10px;
	border-radius:			10px;
	-webkit-border-radius:	10px;			
}

.autorisationOK a,
.autorisationOK a:hover,
.autorisationOK a:visited
{
	font-size:		11px;
	font-weight:	bold;
	color:			green;
}


.autorisationKO a,
.autorisationKO a:hover,
.autorisationKO a:visited
{
	font-size:		11px;
	font-weight:	bold;
	color:			#BE0000;
}

.autorisationOKKO a,
.autorisationOKKO a:hover,
.autorisationOKKO a:visited
{
	font-size:		11px;
	font-weight:	bold;
	color:			#DEA711;
}

.autorisationKO
{
	background-color:	#EE999D;
	color:				#BE0000;
}

.autorisationOKKO
{
	background-color:	#FFD76B;
	color:				#DEA711;
}


.badge {
  display: inline-block;
  min-width: 10px;
  padding: 3px 7px;
  font-size: 12px;
  font-weight: bold;
  line-height: 1;
  color: #ffffff;
  text-align: center;
  white-space: nowrap;
  vertical-align: baseline;
  background-color: #999999;
  border-radius: 10px;
}

.badge-success {
  background-color: #356635;
}


form
{
	margin:		0;
	padding:	0;
}

/****** metro *********/
.metro_artworks,
.metro_combos,
.metro_search,
.metro_echange,
.metro_deck,
.metro_infos,
.metro_versions,
.metro_capacites,
.metro_peremption
{
	float:					left;
	height:					60px;
	width:					60px;
	margin:					3px;
	border-radius:			5px;
	-moz-border-radius:		5px;
	-webkit-border-radius:	5px;	
	box-shadow:				0px 0px 1px 1px #666;
	-moz-box-shadow:		0px 0px 1px 1px #666;
	-webkit-box-shadow:		0px 0px 1px 1px #666;	
	background:				#1E1D19;
	background:				radial-gradient(#E1D4CC, #1E1D19);
	background:				-moz-radial-gradient(#E1D4CC, #1E1D19); 	
	background:				-webkit-radial-gradient(#E1D4CC, #1E1D19);
}

.metro_artworks .fond
{
	height:		60px;
	width:		60px;
	background:	url(../..//images/icones/metro_artworks.png) no-repeat;
}

.metro_combos .fond
{
	height:		60px;
	width:		60px;
	background:	url(../..//images/icones/metro_combos.png) no-repeat;
}

.metro_deck .fond
{
	height:		60px;
	width:		60px;
	background:	url(../..//images/icones/metro_deck.png) no-repeat;	
}

.metro_search .fond
{
	height:		60px;
	width:		60px;
	background:	url(../..//images/icones/metro_search_fr.png) no-repeat;
}

.metro_echange .fond
{
	height:		60px;
	width:		60px;
	background:	url(../..//images/icones/metro_echange_fr.png) no-repeat;
}

.metro_infos .fond 
{
	height:		60px;
	width:		60px;	
	background:	url(../..//images/icones/metro_infos.png) no-repeat;
}

.metro_versions .fond 
{
	height:		60px;
	width:		60px;	
	background:	url(../..//images/icones/metro_versions.png) no-repeat;
}

.metro_capacites .fond 
{
	height:		60px;
	width:		60px;	
	background:	url(../..//images/icones/metro_capacites_fr.png) no-repeat;
}

.metro_peremption .fond 
{
	height:		60px;
	width:		60px;	
	background:	url(../..//images/icones/metro_peremption_fr.png) no-repeat;
}

.metro_artworks .fond .num,
.metro_combos .fond .num,
.metro_search .fond .num,
.metro_echange .fond .num,
.metro_deck .fond .num,
.metro_versions .fond .num,
.metro_capacites .fond .num,
.metro_peremption .fond .num
{
	padding:			0px 5px 0px 5px;
	float:				left ;
	text-align:			center;
	color:				#FFFFFF;
	background:			#BE0000;
	font-size:			12px;
	font-weight:		bold;	
	box-shadow:			0px 0px 1px 1px #666;
	-moz-box-shadow:	0px 0px 1px 1px #666;
	-webkit-box-shadow:	0px 0px 1px 1px #666;	
}

.metro_artworks_small,
.metro_alerte_small,
.metro_search_small,
.metro_small_hqe
{
	float:					left;
	margin:					auto;
	height:					40px;
	width:					40px;
	margin:					5px;
	border-radius:			5px;
	-moz-border-radius:		5px;
	-webkit-border-radius:	5px;	
	box-shadow: 			0px 0px 1px 1px #666;
	-moz-box-shadow: 		0px 0px 1px 1px #666;
	-webkit-box-shadow:		0px 0px 1px 1px #666;
	background:				#1E1D19 ;
	background:				radial-gradient(#E1D4CC, #1E1D19);
	background:				-moz-radial-gradient(#E1D4CC, #1E1D19); 	
	background:				-webkit-radial-gradient(#E1D4CC, #1E1D19);
}

.metro_artworks_small .fond 
{	
	height:		40px;
	width:		40px;	
	background:	url(../..//images/icones/metro_artworks_small.png) no-repeat;
}

.metro_alerte_small .fond 
{	
	height:		40px;
	width:		40px;
	background:	url(../..//images/icones/metro_alerte_small.png) no-repeat;
}

.metro_search_small .fond 
{	
	height:		40px;
	width:		40px;
	background:	url(../..//images/icones/metro_search_small.png) no-repeat;
}

.metro_small_hqe .fond 
{	
	height:		40px;
	width:		40px;
	background:	url(../..//images/icones/metro_small_hqe.png) no-repeat;
}

.metro_artworks_small .num,
.metro_alerte_small .num,
.metro_search_small .num,
.metro_small_hqe .num
{
	padding:			0px 3px 0px 3px;
	float:				left ;
	text-align:			center;
	color:				#FFFFFF;
	background:			green;
	font-size:			11px;
	font-weight:		bold;	
	box-shadow:			0px 0px 1px 1px #666;
	-moz-box-shadow:	0px 0px 1px 1px #666;
	-webkit-box-shadow:	0px 0px 1px 1px #666;	
}

/**** div table ***/
.divTableHeader 
{
	float:			left;
	margin-left:	2.5%;
	padding:		0;
	width:			95%;
	text-align:		center;
	font-size:		11px;
	font-weight:	bold;
	color:			#FFFFFF;
	background:		#1E1D19 ;	
}

.divTableHeaderColumn 
{
	float:		left;
	padding:	3;
	width:		15%;
}

.dataPair,
.dataImpair
{
	float:			left;
	margin-left:	2.5%;
	text-align:		center;	
	margin-top:		10px;
	background:		#E1D4CC;
	-moz-border-radius:		10px;
	border-radius:			10px;
	-webkit-border-radius:	10px;	
	width:			95%;
	padding:5px;
}

.dataImpair
{
	background:	#EFE8E4;
}


.divTableLinePair,
.divTableLineImpair
{
	float:			left;
	margin-left:	2.5%;
	text-align:		center;	
	border-top:		2px solid;
	border-color:	#FFFFFF;
	background:		#E1D4CC;
	width:			95%;
}

.divTableLineImpair
{
	background:	#EFE8E4;
}

.divTableColumn
{
	float:		left;
	padding:	3;
	width:		15%;
}

.dataColumn
{
	display:inline-block;
	float:		left;
	padding:	3;
}

/******** icone **********/
.icone_analyse,
.icone_cartes,
.icone_search,
.icone_statistique,
.icone_decks,
.icone_combos,
.icone_rumeurs,
.icone_vente,
.icone_image
{
	float:	left;
	height:	60px;
	width:	60px;
	margin:	3px;
}

.icone_analyse		
{
	background:	url(../..//images/icone_analyse.png) no-repeat;
}

.icone_search		
{
	background:	url(../..//images/icones/icone_search.png) no-repeat;
}

.icone_statistique		
{
	background:	url(../..//images/icone_statistique.png) no-repeat;
}

.icone_decks		
{
	background: url(../..//images/interface/decks.gif) no-repeat;
}

.icone_combos		
{
	background: url(../..//images/interface/combos.gif) no-repeat;
}
.icone_rumeurs		
{
	background: url(../..//images/icone_rss.png) no-repeat;
}

.icone_cartes		
{
	background: url(../..//images/interface/combos.gif) no-repeat;
}

.icone_vente		
{
	background: url(../..//images/icones/icone_vente.png) no-repeat;
}

.icone_image		
{
	background: url(../..//images/icones/icone_image.png) no-repeat;
}	
	
.icone_analyse .num,
.icone_cartes .num,
.icone_search .num,
.icone_statistique .num,
.icone_decks .num,
.icone_combos .num,
.icone_rumeurs .num,
.icone_vente .num,
.icone_image .num
{
	padding:				0px 5px 0px 5px;
	position:				relative ;
	right:					7px;
	top:					35px;
	float:					right;
	text-align: 			center;
	color:					#FFFFFF;
	background:				#BE0000;
	font-size:				12px;
	font-weight:			bold;
	-moz-border-radius:		2px;
	border-radius:			2px;
	-webkit-border-radius:	2px;
	-moz-box-shadow:		0px 0px 1px 1px #fff;
	-webkit-box-shadow:		0px 0px 1px 1px #fff;
	box-shadow:				0px 0px 1px 1px #fff;			
}



/******** nouveau formulaire ************/
.formulaire,
.formulaire_obligatoire
{
	border:					0px;
	text-align:				left;
	font-family:			Verdana;
	font-size:				11px;
	padding:				0px 0px 8px 0px;	
	margin:					15px;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;
	background-color:		#E1D4CC ;		
}
.formulaire_obligatoire
{
	background-color:	#EFC0A4;
}

.formulaire p.titre,
.formulaire_obligatoire p.titre
{
	background-color:					#EFE8E4;
	background-image:					url('../../images/interface/R1/fond_tableau.jpg');
	font-family:						Verdana;
	font-size:							12px;
	font-weight:						bold;
	color:								#FFFFFF;
	text-align:							center;
	padding:							3 10 3 10;
	margin-right:						auto;
	margin-left:						auto;
	margin-top:							0px;
	width:								70%;
	display:							block;
	-moz-border-radius-bottomleft:		15px;
	border-radius-bottomleft:			15px;
	-webkit-border-radius-bottomleft:	15px;
	-moz-border-radius-bottomright:		15px;
	border-radius-bottomright:			15px;
	-webkit-border-radius-bottomright:	15px;		
}
.formulaire p.titre
{
	/*color:				#FFFFFF;*/
	color:				#000000 ;
	background:			#EFE8E4;
	/*background-image:	url('../../images/interface/B/fond_tableau.jpg');*/
}

.titre_funcards 
{
	background-color:					#EFE8E4;
	font-family:						Verdana;
	font-size:							11px;
	text-align:							center;
	padding:							2px;
	margin-right:						auto;
	margin-left:						auto;
	margin-bottom:						10px;
	width:								90%;
	display:							block;
	-moz-border-radius-bottomleft:		8px;
	border-radius-bottomleft:			8px;
	-webkit-border-radius-bottomleft:	8px;
	-moz-border-radius-bottomright:		8px;
	border-radius-bottomright:			8px;
	-webkit-border-radius-bottomright:	8px;
	-moz-box-shadow:					0px 2px 2px #969595;
	-webkit-box-shadow:					0px 2px 2px #969595;
	box-shadow:							0px 2px 2px #969595;		
}

.formulaire li,
.formulaire_obligatoire li
{
	display:		inline;
	position:		relative;
	float:			left;
	text-align:		left;
	width:			40%;
	list-style:		none;
	border:			0px;
	margin:			5px;
	padding:		2px 0px 2px 0px;
	font-weight:	bold;		
}

.formulaire ul,
.formulaire_obligatoire ul
{		
	margin:		15px;
	padding:	0px;
	text-align:	center;
}

.formulaire li.long,
.formulaire_obligatoire li.long
{
	width:	590px;
}

.formulaire p,
.formulaire_obligatoire p
{
	text-align:		left;
	margin-bottom:	2px;
	padding:		2px;		
}
.formulaire .saisie,
.formulaire_obligatoire .saisie 
{
	margin-top:				5px;
	padding:				0px;
	font-size:				11px;
	border:					4px solid;
	border-color:			#FFFFFF;
	-moz-border-radius:		5px;
	border-radius:			5px;
	-webkit-border-radius:	5px;			
}

.formulaire select,
.formulaire_obligatoire select 
{
	font-size:				11px;
	border:					3px solid;
	border-color:			#FFFFFF;
	padding:				1px;		
	-moz-border-radius:		5px;
	border-radius:			5px;
	-webkit-border-radius:	5px;			
}
/********* fin de nouveau formulaire **********/

.cadre_donnees,
.cadre_donnes_autorisations 
{
	background-color:		#E1D4CC;
	margin:					10px;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;
}

.cadre_donnes_autorisations 
{
	padding:		4px;
	width:			180px;
	text-align:		center;
	margin-left:	40px;
}	
	
.recherche
{
	background-color:		#E1D4CC;
	background-position:	left bottom;
	background-repeat:		no-repeat;
	background-image:		url('../../images/search.png');
	font-size:				10px;
	padding:				0px;
	width:					600px;
	display:				block;
	margin-left:			auto;
	margin-right:			auto;
	margin-top:				15px;
	margin-bottom:			15px;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;
}

.decompte_element
{
	background-color:					#EFE8E4;
	font-size:							10px;
	text-align:							center;
	padding:							2px;
	margin-right:						auto;
	margin-left:						auto;
	width:								340px;
	display:							block;
	-moz-border-radius-bottomleft:		8px;
	border-radius-bottomleft:			8px;
	-webkit-border-radius-bottomleft:	8px;
	-moz-border-radius-bottomright:		8px;
	border-radius-bottomright:			8px;
	-webkit-border-radius-bottomright:	8px;		
}

/********* formulaires *******/
.error,
.success 
{
	font-family:	Verdana;
	font-weight:	bold;
	font-size:		12px;
	color:			red;
	text-align:		center;
	margin:			5px;
}

.success 
{
	color:	green;
}

.selectInput 
{
	font-family:	Verdana;
	font-size:		11px;
	border:			1px solid #CCC5B2;
}

.selectTitle
{
	font-family:	Verdana;
	font-weight:	bold;
	color:			black;
	font-size:		11px;
}

.buttonInput
{
	font-family:		Verdana;
	font-size:			11px;
	font-weight:		bold;
	border:				1px solid;
	background-color:	#E1D4CC;
}

.textInput
{
	font-family:	Verdana;
	font-size:		11px;
	border:			1px solid #E1D4CC;
	margin:			1px;
}

.searchInput
{
	background:				url(../../images/interface/searchFont.png)  no-repeat;
	background-position:	right;
	font-family:			Verdana;
	font-size:				11px;
	border:					0px;
	width:					152px;
	height:					22px;
	padding:				5 0 5 25;
	margin:					0;
	font-weight:			bold;	
	-moz-border-radius:		6px;
	-webkit-border-radius:	6px;	
	border-radius:			6px;
	vertical-align:			center;
}

/********** tableaux *********/

.formTable,
.contentTable 
{
	border-collapse:	collapse; 	
}

.formTableHeader,
.contentTableHeader 
{
	height:		20px;
	background:	#34312C;
}

tr.formTableHeader td,
tr.contentTableHeader td 
{
	background:		#34312C;
	color:			#FFFFFF;
	font-weight:	bold;
	font-size:		11px;
	padding:		4px;	
	border-top:		2px solid #FFFFFF;
	border-bottom:	2px solid #FFFFFF;		
}

tr.formTableFooter td,
tr.contentTableFooter td 
{
	color:			#000000;
	text-align:		center;
	font-weight:	bold;
	font-size:		12px;
	padding-left:	5px;
}

tr.contentTrPair td,
tr.contentTrImpair td,
tr.contentMPRead td,
tr.contentMPNonRead td
{
	background-color:	#E1D4CC;
	padding:			4px;
	border-top:			2px solid #FFFFFF;
	border-bottom:		2px solid #FFFFFF;	
	vertical-align:		middle;	
}

tr.contentTrImpair td 
{
	background-color:	#EFE8E4;
}


.contentMPNonRead, .contentMPRead
{
	background-color:	#E1D4CC;
	border-top:			4px solid #FFFFFF;
	vertical-align:		middle;
	margin-left:2.5%;
	width:95%;
	text-align:left;
}


.contentMPRead 
{
	background-color:	#E5E5E5;
}

.contentMPNonRead 
{
	background-color:	#F5D1BD;
}

tr.contentMPNonRead td
{
	background-color:	#F5D1BD;
}

.formTableCol1 
{
	background-color:	#E1D4CC;
	font-weight:		bold;
}

.formTableCol
{
	background-color:	#EFE8E4;
}

/** fou / pas fou **/
.display_fou,
.display_pasfou
{
	font-size:		11px;
	font-weight:	bold;
	color:			#FFFFFF;
	text-align:		center;
	padding-top:	5px;	
	margin:			5px;		
	width:			25px;
	height:			25px;
	display:		block;	
}

.display_fou
{
	background-image:	url('../../images/fou_small.png') ;
	background-repeat:	no-repeat;		
}

.display_pasfou
{
	background-image:	url('../../images/pasfou_small.png') ;
	background-repeat:	no-repeat;		
}	
		
/**** formulaires ***/
.tag_box_small,
.tag_box 
{
	border:				1px solid black;	
	font-size:			10px ;
	text-decoration:	bold;
	background-color:	#FFFFFF;
	height:				16px;
	width :				28px;
	text-align:			center;
	margin:				3px;
	float:				left;
}

.tag_box 
{
	width :	50px;
}

.tag_box_small a,
.tag_box a 
{
	font-size:	10px ;
	text-align:	center;
}

.post 
{
	font-family:	Verdana;
	font-size:		11px;
	color:			#000000;
}

.quote
{
	font-family:		Verdana, Arial, Helvetica, sans-serif;
	font-size:			10px;
	color:				#000000;
	line-height:		125%;
	background-color:	#FAFAFA;
	border:				#D6D6D6;
	border-style:		solid;
	border:				1px;
}

/************ menu jquery *****/
#jsddm,
#jsddm2
{	
	display:		block;
	margin-top:		0px;
	margin-left:	0px;
	padding:		0;
	z-index:1001;
}
	
#jsddm li,
#jsddm2 li
{
	float:		left;
	list-style:	none;
	font:		14px "Plantin OUP", Tahoma, Verdana, Arial;
}

#jsddm li a:hover,
#jsddm2 li a:hover
{
	/*background:		#1A4473;*/
	font:			11px Verdana, Arial;
	font-weight:	bold;
}

#jsddm li a,
#jsddm2 li a
{	
	display:			block;
	font:				11px Verdana, Arial;
	font-weight:		bold;
	padding:			5 8 2 9;
	text-decoration:	none;
	/*border-right:		1px solid white;*/
	width:				auto;
	color:				#000000;
	white-space:		nowrap;
	z-index:1001;
}

#jsddm li a:hover,
#jsddm2 li a:hover
{	
	/*background:		#1A4473;*/
	color:			#BE0000;	
}

#jsddm li ul,
#jsddm2 li ul
{	
	margin:					0;
	padding:				0;
	position:				absolute;
	visibility:				hidden;
	border:					1px solid #000000;
	/*-moz-border-radius:		8px;
	-webkit-border-radius:	8px;
	background:				#E1D4CC;*/
}

#jsddm li ul li,
#jsddm2 li ul li
{	float:		none;
	display:	inline
}

#jsddm li ul li a,
#jsddm2 li ul li a
{	
	width:								auto;
	background:							#E1D4CC;
	filter:								alpha(opacity=90);
	-moz-opacity:						0.90;
	opacity:							0.90;
	-moz-border-radius-topright:		0px;
	-moz-border-radius-topleft:			0px;
	-webkit-border-top-right-radius:	0px;
	-webkit-border-top-left-radius:		0px;
	border-radius-topright:				0px;
	border-radius-topleft:				0px;	
}

#jsddm li ul li a:hover, #jsddm2 li ul li a:hover
{
	background:							#E1D4CC;
	filter:								alpha(opacity=100);
	-moz-opacity:						1;
	opacity:							1;
	-moz-border-radius-topright:		0px;
	-moz-border-radius-topleft:			0px;
	-webkit-border-top-right-radius:	0px;
	-webkit-border-top-left-radius:		0px;
	border-radius-topright:				0px;
	border-radius-topleft:				0px;	
}

#jsddm li ul li hr,
#jsddm2 li ul li hr
{
	background:		#E1D4CC;
	filter:			alpha(opacity=85);
	-moz-opacity:	0.85;
	opacity:		0.85;		
	width:			auto;
	height:			1px;
	color:			#000000;
}

img 
{
	border:	none;
}

/************ bas de page **************/
#citation_bas_de_page_haut
{
	border-bottom:	15px solid #E1D4CC;
	border-left:	8px solid #FFFFFF;
	border-right:	8px solid #FFFFFF;	
	font-size:		0px;
	line-height:	0%;
	width:			0px;
	margin-left:	50px;
	margin-right:	450px;
}

#citation_bas_de_page 
{
	background-color:		#E1D4CC;
	text-align:				left;
	padding:				8px;
	width:					584px;
	display:				block;
	margin-left:			auto;
	margin-right:			auto;	
	-moz-border-radius:		5px;
	-webkit-border-radius:	5px;
	border-radius:			5px;
}

/**** nouveau format de commentaires ****/
.triangle_commentaire_new
{
	border-bottom:	12px solid #EFE8E4;
	border-left:	8px solid #E1D4CC;
	border-right:	8px solid #E1D4CC;
	font-size:		0px;
	line-height:	0%;
	width:			0px;
	margin-left:	25px;	
}

.triangle_commentaire_reponse
{
	border-bottom:	12px solid #EFE8E4;
	border-left:	8px solid #fff;
	border-right:	8px solid #fff;
	font-size:		0px;
	line-height:	0%;
	width:			0px;
	margin-left:	25px;	
}

.dataTeaserTriangle
{
	float:left;
	width: 0; 
	height: 0; 
	border-top: 10px solid #EFE8E4;
	border-bottom: 10px solid #EFE8E4; 
	border-right:17px solid #E1D4CC; 
	margin-top:	15px;
	margin-left:5px;
}

.dataTeaserContent
{
	float:left;
	background-color:		#E1D4CC;
	font-family:			Verdana;
	font-size:				11px;
	text-align:				left;
	padding:				5px;
	border:					0px;
	width:80%;
	margin-top:	5px;
	min-height:30px;
}

.dataHr
{
	border: 0;
	height:2px;
	color:#E1D4CC;
	background-color:#E1D4CC;
}

.dataHrThin
{
	border: 0;
	height:1px;
	color:#E1D4CC;
	background-color:#E1D4CC;
	margin-bottom:10px;
	margin-top:20px;
}

.commentaire_new 
{
	background-color:		#EFE8E4;
	font-family:			Verdana;
	font-size:				11px;
	text-align:				left;
	padding:				8px;
	display:				block;
	-moz-border-radius:		8px;
	-webkit-border-radius:	8px;
	border-radius:			8px;
	border:					0px;
}

.note_bon,
.note_moyen,
.note_mauvais 
{
     position:		relative; /* IE hack */
     width:			90px;
     border:		1px solid #5AC20F;
     margin:		1 ;
     margin-top:	3px;	 
     background:	#FFFFFF;	 
}

.note_bon .barre,
.note_moyen .barre,
.note_mauvais  .barre 
{
	 display:		block;
     position:		relative;
     background:	#5AC20F;
     text-align:	center;
     color:			#FFFFFF;
     height:		1.3em;
     line-height:	1.3em;
}

.note_moyen 
{
     border:	1px solid #F2C12E;
}

.note_mauvais 
{
     border:	1px solid #BE0000;
}

.note_moyen .barre 
{
     background:	#F8F5A8;
}

.note_mauvais  .barre 
{
     background:	#BE0000;
}

.cadre_info,
.cadre_info_small,
.cadre_info_long,
.cadre_info_small2
{
	background-color:		#EFE8E4;
	font-family:			Verdana;
	font-size:				11px;
	text-align:				left;
	padding:				5px;
	width:					40%;
	display:				block;
	margin:					5px;
	float:					left;
	position:				relative;			
	-moz-border-radius: 	4px;
	-webkit-border-radius:	4px;
	border-radius:			4px;
}

.cadre_info_small
{	
	width:	25%;
}

.cadreRondLong
{
	background-color:		#EFE8E4;
	font-family:			Verdana;
	font-size:				11px;
	text-align:				left;
	padding:				10px;
	width:					90%;
	display:				block;
	margin:					auto;	
	-moz-border-radius: 	10px;
	-webkit-border-radius:	10px;
	border-radius:			10px;
}

/**** Affichage des combos ***/
/* thumbnail list decks */
ul#thumbsdeck,
ul#thumbsdeck li
{
	margin:		0;
	padding:	0;
	list-style:	none;
	text-align:	center;
}

ul#thumbsdeck li
{
	float:			left;
	margin-right:	5px;	
	padding:		2px;
}

ul#thumbsdeck a
{
	display:	block;
	float:		left;
	width:		70px;
	height:		70px;
	overflow:	hidden;
	position:	relative;
	z-index:	1;		
}

ul#thumbsdeck a img
{
	float:		left;
	position:	absolute;
	top:		-38px;
	left:		-50px;	
}

/* thumbnail list */
ul#thumbscombo,
ul#thumbscombo li
{
	margin:		0;
	padding:	0;
	list-style:	none;
	text-align:	center;
}

ul#thumbscombo li
{
	float:			left;
	margin-right:	5px;
	border:			1px solid #999;	
	padding:		2px;
}

ul#thumbscombo a
{
	display:		block;
	float:			left;
	width:			70px;
	height:			70px;
	line-height:	70px;
	overflow:		hidden;
	position:		relative;
	z-index:		1;		
}

ul#thumbscombo a img
{
	float:		left;
	position:	absolute;
	top:		-38px;
	left:		-50px;	
}

/* mouse over */
ul#thumbscombo a:hover
{
	overflow:	visible;
	z-index:	1000;
	border:		none;		
}

ul#thumbscombo a:hover img
{
	border:		1px solid #999;	
	background:	#FFFFFF;
	padding:	2px;			
}	

/* clearing floats */
ul#thumbscombo:after,
li#thumbscombo:after
{
	content:	"."; 
	display:	block; 
	height:		0; 
	clear:		both; 
	visibility:	hidden;
}

ul#thumbscombo,
li#thumbscombo
{
	display:	block;
}

ul#thumbscombo,
li#thumbscombo
{
	min-height:	1%;
}

* html ul#thumbscombo,
* html li#thumbscombo
{
	height:	1%;
}	

/************************************************/
/* This is the style for the popupdescriptions. */
/************************************************/
#divTooltip
{
	position:				absolute; 
	top:					0px; 
	width:					250px; 
	visibility:				hidden; 
	z-index:				200; 
	border-radius:			5px;
	-webkit-border-radius:	5px;
	-moz-border-radius:		5px;
	border-radius:			5px;
	padding:				2px ;
	border:					1px solid #000000;	
	background-color:		#000000;
}

.divTooltip_lexique 
{
	background-color:	#E1D4CC;
	padding:			2px ;	
}

.normalStyle 
{
	padding:				2px;
	text-align:				left;
	font-weight:			500;
	width:					175px;
	color:					#000000;
	top:					100px;
	font-family:			Verdana, Arial, Helvetica;
	font-size:				11px;
	background-color:		#E1D4CC;
	layer-background-color:	#E1D4CC;
	border-width:			1px;
	border-style:			solid;
	border-color:			#000000;
	cursor:					default;
}

.netscape4Style 
{
	padding:				0px;
	font-weight:			500;
	width:					175px;
	color:					#000000;
	top:					100px;
	font-family:			Verdana, Arial, Helvetica;
	font-size:				11px;
	background-color:		#E1D4CC;
	layer-background-color:	#E1D4CC;
	border:					1px solid #000;
}  


.bouton_merde_DMconsole,
.bouton_merde_cherche 
{
	background-color:		#FFFFFF;
	background-repeat:		no-repeat;
	background-position:	8px center;
	background-image:		url('../../images/soleil.png');			
	text-align:				left;
	padding:				8px 8px 8px 37px;
	width:					250px;
	margin:					5px;
	font-family:			Verdana;
	font-size:				11px;
	font-weight:			bold;
	color:					#000000;
	border-style:			solid;
	border-width:			1px;		
	border-bottom-color:	#B2B2B2;
	border-right-color:		#B2B2B2;		
	border-top-color:		#FFFFFF;
	border-left-color:		#FFFFFF;
	-moz-border-radius:		8px;
	border-radius:			8px;
	-webkit-border-radius:	8px;			
}	

.bouton_merde_cherche 
{
	width:				190px;
	background-image:	url('../../images/mort.png');		
}
	
.bouton_merde_cherche:hover,
bouton_merde_DMconsole:hover
{		
	background-color:	#EFE8E4;
	cursor:				pointer;		
}	

/*** Forum ***/
.forum_topic_pair,
.forum_topic_impair,
.forum_topic_titre
{
	margin-left:	1%;
	width:			98%;
	background:		#EFE8E4;
	margin-bottom:	2px;
}

.forum_topic_impair
{
	background:	#E1D4CC;
}

.forum_topic_titre
{
	background:	#1E1D19;
	color:		#FFFFFF;
}

.bulle 
{
	display:	block;
	color:		#FFFFFF;
}

.bulle-arrow 
{
	margin-left:	0px;
	width:			0;
	height:			0;
	border-left:	0px solid transparent;
	border-right:	10px solid transparent;
	border-top:		8px solid #1E1D19;
}

.bulle-text 
{
	padding-top:			1px;
	width:					30px;
	height:					20px;
	-moz-border-radius:		10px;
	-webkit-border-radius:	10px;
	border-radius:			10px;
	background:				#1E1D19 ;
	color:					#FFFFFF;
	text-align:				center;
	font-weight:			bold;
}

.bulle-forum 
{
	float:			left;
	color:			#FFFFFF;
	margin-left:	5px;
}

.bulle-forum-arrow 
{
	margin-left:	0px;
	width:			0;
	height:			0;
	border-left:	0px solid transparent;
	border-right:	10px solid transparent;
	border-top:		8px solid #E1D4CC;
}

.bulle-forum-text
{
	padding-top:			2px;
	width:					30px;
	height:					20px;
	-moz-border-radius: 	10px;
	-webkit-border-radius:	10px;
	border-radius:			10px;
	background:				#E1D4CC ;
	color:					#1E1D19;
	text-align:				center;
	font-weight:			bold;
}

.forum_barre
{
	height:				30px;
	width:				294px;
	background:			#1E1D19;
	color:				#FFFFFF;
	padding:			3px;
	text-decoration:	none;
}

.nounderline:hover
{
	text-decoration:	none;
}


.bloc-de-texte 
{
	background-color:#ffffff;
	color:#000000;
	border-top:3px solid;
	border-color:#1E1D19;
	border-radius:5px;
	margin:5px;
	padding:15px;
	line-height:25px;
}

