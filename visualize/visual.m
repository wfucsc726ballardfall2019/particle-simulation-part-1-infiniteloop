function visual(file)
    positions = readmatrix(file);

    n = positions(1,1);
    colors = rand(n,3);

    loops = (length(positions)-1)/n;

    scatter(positions(2:2+n-1,1), positions(2:2+n-1,2));
    s = getframe;
    s = s.cdata;
    diameter = size(s,1)/positions(1,2)*0.02;

    M = zeros([size(s) loops]);
    for i=1:loops
        start=(i-1)*n+2;
        stop = start+n-1;
        whitebg('black'); %#ok<WHITEBG>
        scatter(positions(start:stop,1), positions(start:stop,2), diameter, colors, 'filled');
        drawnow;
        f = getframe;
        M(:,:,:,i) = f.cdata;
    end
    close all;

    v = VideoWriter(file, 'MPEG-4');
    open(v);
    writeVideo(v,uint8(M));
    close(v);
end
