var imgs = document.getElementsByTagName("img");
var imgSrcs = [];

for (var i = 0; i < imgs.length; i++) {
    imgSrcs.push(imgs[i].src);
}
var finalImgs = []

for (img in imgSrcs) {
    console.log("Checking: " + imgSrcs[img].substr(0,34));
    if (imgSrcs[img].substr(0,34) === "https://lh3.googleusercontent.com/"){
        finalImgs.push(imgSrcs[img]);
        console.log(imgSrcs[img]);
    }
}


function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

for (img in finalImgs) {
    ele = document.createElement('a');
    srcLink = finalImgs[img];
    srcLinkResized = srcLink.replace(/=w.*-h.*-rw/,'=w0-h0');
    ele.href = srcLinkResized;
    ele.download = 'image.jpg';
    console.log(ele);
    ele.remove();
    if (img%10 === 0){
        console.log("Waiting at : " + img);
        await sleep(10000);
    }
    ele.click();
}
