function horspool(pat,searchStr) {
    if (arguments.length < 1) return horspool;
    var bmBc = preBmBc(pat,256);
    var m = pat.length;
    function search(str) {
        if (arguments.length < 1) return search;
        var c, j = 0;
        var n = str.length;
        var matches = new Array();
        while (j <= n - m) {
            c = str[j + m - 1];
            if (pat[m - 1] == c) {
                // first letter match. let's check the rest
                if (pat.compareTo(str.slice(j,j + m))) {
                    matches.push(j);
                }
            }
            j += bmBc[c];
        }
        return matches;
    }
    if (arguments.length > 1) {
        return search(searchStr);
    } else {
        return search;
    }
}
