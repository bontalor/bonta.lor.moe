function createSpam() {
  const url = "https://cdn.betterttv.net/emote/55f1cc2b4bbea27f0a7cb210/3x"
  const img = document.createElement('img')
  img.src = url
  img.className = "raremonkey"

  const div = document.createElement('div')
  div.style="display:inline;"
  div.appendChild(img)

  const text = " I can't wait for mizzy wizzy's stream today "
  const span = document.createElement('span')
  span.innerText = text
  div.appendChild(span)

  document.querySelector('.sitemessage').appendChild(div)
}

const count = 10;
[...Array(count)].map(createSpam)