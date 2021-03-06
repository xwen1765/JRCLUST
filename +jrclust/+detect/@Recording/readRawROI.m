function roi = readRawROI(obj, rows, cols)
    %READRAWROI Get a region of interest by rows/cols from the raw file
    rowPred = jrclust.utils.ismatrixnum(rows) && ~isempty(rows) ...
        && all(rows > 0) && max(rows) <= obj.dshape(1);

    colPred = jrclust.utils.ismatrixnum(cols) && ~isempty(cols) ...
        && all(cols > 0) && issorted(cols) ...
        && cols(end) <= obj.dshape(2);

    assert(rowPred, 'malformed rows');
    assert(colPred, 'malformed cols');

    if obj.rawIsOpen % already open, don't close after read
        doClose = 0;
    else
        obj.openRaw();
        doClose = 1;
    end

    roi = obj.rawData(rows, cols);

    if doClose
        obj.closeRaw();
    end
end