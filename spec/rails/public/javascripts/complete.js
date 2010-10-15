function preBmBc(str,size) {
    var bmBc = new Array(size);
    var m = str.length;
    for (var i = 0; i < bmBc.length; i++) { bmBc[i] = m; }
    for (var i = 0; i < m-1; i++) {
        bmBc[str[i]] = m - i - 1;
    }
    return bmBc;
}

function horspool(pat,str) {
    var matches = new Array();
    var m = pat.length;
    var n = str.length;
    var bmBc = preBmBc(pat,256);
    var c, j = 0;
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
