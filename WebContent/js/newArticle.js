jQuery(function ($) {
	$('form').on('reset', function (evt) {
        evt.preventDefault();
        $('form')[0].reset();
        $('#id_engineer,#id_cc').each(function (el, i) {
            $(this).tokenfield('setTokens', $(this).attr('value').split(';'));
        });
    });
	var userName = ['신상헌','정융기','장승훈','홍종민'];
	
    $('fieldset').prop('disabled', false);
    
    $('#ar_tag').tokenfield({
		delimiter: ';',
		createTokensOnBlur: true	
	});
    
    $('#ar_engineer,#ar_cc').tokenfield({
		autocomplete: {
//	    source: ['신상헌','정융기','장승훈','홍종민','박세원','함창원','둘리','김전일','이승기','하하','매드클라운','아이유','소유','EXID','AOA'],
		source: userName,
	    delay: 100
		  },
		  showAutocompleteOnFocus: true,
		  delimiter: ';',
		  beautify: true,
		  createTokensOnBlur: true
    });

});