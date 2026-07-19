# CLAUDE.md — speedskating3d(速度滑冰 3D,冬奧皮)

> 2026-07-20 建站:fork 自 equestrian3d(A2 速度滑冰)。核心手感=左右交替節奏蹬步
> (athletics3d 節奏判定搬來)+彎道傾身;同機雙人照 duel-2p-kit §7C 競速型。
> 尚未部署;上架時走 CF Pages(/ship-cf,2026-07-19 鐵則:新站一律 Cloudflare)。

## 引擎核心(換皮時別動的)

- 賽道=解析式 stadium:`ovalPoint(dist, laneOffset)`(兩直道 55m+兩個 180° 彎 R22,
  周長 ≈248m),一切以「里程 dist」為域;`inBendAt(dist)` 驅動彎道機制。分道=法線偏移
  (內道 −1.9 / 外道 +1.9)。
- 節奏蹬步:`tapPush(racer, side)`——連按同側=踉蹌(×0.8+短暫無力);gap<0.14s=太急;
  否則 `q = 1 - |gap - ideal|/tol`(athletics 同款),`applyPush` 收斂到 maxSpeed。
- 彎道:沒傾身 drag 0.5(溫柔減速)、傾身/直道 drag 0.1(滑行慣性=「蹬一下滑出去」)。
- racer 結構 P1/P2/AI 統一(duel-2p-kit §7C):AI=節拍器輸入,`_isHuman()` 單閘門;
  solo 時 P2 鍵(方向鍵)別名回 P1,不變死鍵。
- `makePerson`:上半身收進 `torso` 樞紐(腰)→ 前傾蹲姿只轉 torso.rotation.x;
  緊身衣上下同色+同色連帽;冰刀=靴下薄長盒;臉部鐵則(眼耳嘴眉)不動。
- 傾身 roll:此參數化下「內側=局部 +x」→ 內傾=**負** rotation.z(placeRacer)。
- `this.running` 只給 RAF(athletics 撞名事故鐵則——絕不再宣告同名狀態)。
- P1 紅衣、P2 藍衣、AI 綠衣(任務拍板;duel-2p-kit 的 P1 藍在本作讓位給任務規格)。

## 本機地雷

- vite preview 接 `| head` 會被 SIGPIPE 收掉——背景跑不要接管線。
- 貼地面片要 `rotation.order="YXZ"` 先 yaw 再倒平(XYZ 會鋸齒)。
- `.bat` 純 ASCII+CRLF(PowerShell 寫);run.bat 用 port 5219 避撞。
- msedge-tts 這台偶爾一句就死:gen-voice.mjs 逐句落盤,重跑到「新產 0」即完成。
- 溝通一律繁體中文。

## 驗證

`npm run build`(檢查 dist/ 有真產物)→ `npx vite preview` →
`node scripts/verify-speedskating.mjs http://localhost:4173 scripts/shots`
(單人 kids/normal、雙人、練習、彎道傾身,全程 0 pageerror 才綠)。

## 部署

尚未部署。beacon 雙平台版已鋪(index.html `window.psPing`,只擋 localhost;
id=speedskating3d,-start/-done 帶 t 秒)。sw.js CACHE_NAME=speedskating-nf1,改版要 bump。
