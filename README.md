# 速度滑冰 3D(speedskating3d)

> HFPC 3D 系列 A2(2026-07-20,fork 自 equestrian3d 騎乘引擎)——標準速滑橢圓
> (兩直道+兩個 180° 彎道),核心手感=**左右交替節奏蹬步**(搬 athletics3d 節奏判定)
> +**彎道傾身**。冬奧皮;含同機雙人(duel-2p-kit §7C 競速型)。

## 玩法

- **單人競速**:跟 AI 選手內外道對決,先滑完全部圈數(難度定 2~3 圈)的贏。
- **雙人同機**:P1(紅)=A/D 交替蹬+W 傾身;P2(藍)=←/→ 交替蹬+↑ 傾身,內外道各一人。
- **練習場**:無對手、無限圈,自由練節奏。

左右**交替**按鍵=蹬冰:交替且節奏穩=越滑越快;連按同側或太急=踉蹌減速(溫柔,不摔倒、
永遠滑得完)。進彎道 HUD 會提示——**按住傾身鍵**內傾過彎不減速,沒按=彎道自然減速(不懲罰性)。
單人模式方向鍵是 P1 的別名(沒有死鍵);平板點畫面=自動左右交替蹬。

- 五難度:幼兒(強輔助+AI 慢+2 圈)→ 職業(節奏窗窄+AI 快+3 圈)。
- P1 紅衣、P2 藍衣、AI 綠衣;冰刀/緊身連帽/前傾蹲姿照 3d-figure-kit 鐵則。

## 開發

```bash
npm install
npm run dev                      # 本機試玩(dev 不註冊 SW);run.bat=port 5219
npm run build                    # 產物在 dist/
node scripts/gen-voice.mjs       # 烤人聲(雲哲 14 句;產物進 git,離線可玩)
node scripts/verify-speedskating.mjs <url> <outDir>  # Playwright 端到端(單人×2難度/雙人/練習/彎道傾身)
```

引擎重點:解析式 stadium 賽道(`ovalPoint(dist, laneOffset)` 里程域,直道+180° 彎,
分道=法線偏移)、節奏判定 `q = 1 - |gap - ideal|/tol`(athletics 同款)、racer 結構
P1/P2/AI 統一只差輸入來源、`this.running` 只給主迴圈 RAF(athletics 撞名事故鐵則)。
人聲鐵律:預烤 mp3(雲哲),缺檔只出字幕、絕不用 Web Speech 機器聲。

## 部署

尚未部署(依 2026-07-19 鐵則:新站一律 Cloudflare Pages,走 /ship-cf)。
beacon 已是雙平台版(只擋 localhost),遊戲 id=`speedskating3d`(載入/-start/-done 帶 t)。
