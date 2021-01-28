var Translit = new function()
{
	var ru_str = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя1234567890 -_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var en_str = ['a','b','v','g','d','e','jo','zh','z','i','j','k','l','m','n','o','p','r','s','t',
	'u','f','h','c','ch','sh','shh','','i','i','je','ju',
	'ja','a','b','v','g','d','e','jo','zh','z','i','j','k','l','m','n','o','p','r','s','t','u','f',
	'h','c','ch','sh','shh','','i','i','je','ju','ja',
	// Поле букв
	1,2,3,4,5,6,7,8,9,0,
	// После цифр
	'-','-','_',
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
	'v', 'w', 'x', 'y', 'z',
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
	'V', 'W', 'X', 'Y', 'Z'];
    var el = this;

	this.get = function(org_str) {
		var tmp_str = "";
		for(var i = 0, l = org_str.length; i < l; i++) {
			var result = org_str.charAt(i);
			var n = ru_str.indexOf(result);
			if(n >= 0) { tmp_str += en_str[n]; }
			//else { tmp_str += result; }
		}
		return tmp_str;
	}

    this.set = function(selector1, selector2){
        if ($(selector1).size() == 0 || $(selector2).size() == 0) return;

        $( selector1).unbind( "keyup" );
        $(selector1).keyup(function(){
        	if ($(selector2).size() > 0 && !$(selector2)[0].disabled &&
        		(!$(selector2).attr('readonly')) ){
                var str = strip_tags(this.value);
            	$(selector2).val(el.get( strip_tags(str) ));
        	}
        });
    }
}

function strip_tags (input, allowed) {
    allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join(''); // making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)
    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
        commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
    return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
        return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
    });
}
