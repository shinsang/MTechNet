jQuery(function ($) {
    $('form').on('reset', function (evt) {
        evt.preventDefault();
        $('form')[0].reset();
        $('#regions,#tags').each(function (el, i) {
            $(this).tokenfield('setTokens', $(this).attr('value').split(';'));
        });
    });
    $('fieldset').prop('disabled', false);
    $('#engineer,#cc').tokenfield({
		autocomplete: {
	    source: ['신상헌','정융기','장승훈','홍종민','박세원','함창원','둘리','김전일','이승기'],
	    delay: 100
		  },
		  showAutocompleteOnFocus: true,
		  delimiter: ';',
		  createTokensOnBlur: true
    });
	$('#tag').tokenfield({
		delimiter: ';',
		createTokensOnBlur: true	
	});
});