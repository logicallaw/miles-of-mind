/*
    This is file of the project miles-of-mind
    Licensed under the MIT License.
    Copyright (c) 2025 Junho Kim
    For full license text, see the LICENSE file in the root directory or at
    https://opensource.org/license/mit
    Author: Junho Kim
    Latest Updated Date: 2025-04-28
*/
function alertForUser() {
  var results = '';

  var obj;

  // 게시물 번호
  obj = document.getElementById('post-number');
  results += `게시물 번호:${obj.value}\n`

  // 게시물 제목
  obj = document.getElementById('post-title');
  results += `게시물 제목: ${obj.value}\n`;

  // 게시물 중요여부
  obj = document.getElementById('important-post');
  results += `게시물 중요여부: ${(obj.checked) ? true : false}\n`;

  // 게시물 본문(내용)
  obj = document.getElementById('post-body');
  results += `게시물 본문(내용): ${obj.textContent} \n`;

  // 게시물 배경색
  obj = document.getElementById('post-backgroundColor');
  results += `게시물 배경색: ${obj.value}\n`;

  // 게시물 첨부 그림 파일명
  obj = document.getElementById('post-file');
  results += (obj.value.length === 0) ?
      `게시물 첨부 파일명: C:\\fakepath\\assets\\default-image.png\n` :
      `게시물 첨부 파일명: ${obj.value}\n`;

  // 게시물 작성일
  obj = document.getElementById('post-date');
  const text = obj.textContent.replace('작성일', '').trim();
  results += `게시물 작성일: ${text}\n`;

  // 결과물 출력
  alert(results);
  return true;
}