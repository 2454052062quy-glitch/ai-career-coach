<!-- SPDX-License-Identifier: MIT -->
# AI Career Coach

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Data: CC BY 4.0](https://img.shields.io/badge/Data-CC_BY_4.0-green.svg)](data/LICENSE)

> 🇬🇧 **English version:** [README.en.md](README.en.md)

Trợ lý định hướng nghề nghiệp và luyện phỏng vấn thông minh, **cá nhân hoá theo sở thích và kinh nghiệm** của từng sinh viên. Ứng dụng chạy hoàn toàn trên máy của bạn nhờ [Ollama](https://ollama.com), mã nguồn mở, không cần API key và không gửi hồ sơ của bạn ra ngoài.

Dự án của đội **TQL** cho cuộc thi *Phát triển ứng dụng nguồn mở* (Bảng 3), Khoa CNTT, Trường Đại học Mở TP.HCM, năm 2026.

![Demo](docs/images/demo.gif)

## Tính năng

- **Hồ sơ cá nhân:** kỹ năng (mức 1–5), sở thích theo chủ đề, kinh nghiệm (dự án, thực tập, câu lạc bộ, cuộc thi), có thể tải CV để tự điền.
- **Khoảng cách năng lực (Skill Gap):** đối chiếu hồ sơ với vị trí có sẵn hoặc với một tin tuyển dụng (JD) bạn dán vào; điểm phù hợp gồm kỹ năng, sở thích và kinh nghiệm, kèm lý do gợi ý bằng chữ.
- **Lộ trình học theo tuần:** xếp nhiệm vụ nhỏ 15–30 phút vào các buổi rảnh của bạn, nhắm vào điểm còn yếu.
- **Nhiệm vụ hằng ngày và chuỗi ngày:** giữ thói quen học đều.
- **Báo cáo tuần:** thống kê giờ học thực tế, nhiệm vụ đã xong, kỹ năng tiến bộ; hỏi lịch tuần sau rồi lập lại kế hoạch.
- **Bộ câu hỏi phỏng vấn:** câu chuẩn của vị trí và câu bám vào chính dự án của bạn; tự trả lời trước rồi mới xem gợi ý.

## Cách hoạt động

1. **Nhập hồ sơ:** bạn khai kỹ năng, sở thích, kinh nghiệm, hoặc tải CV để ứng dụng tự điền.
2. **Chọn mục tiêu:** chọn một vị trí có sẵn hoặc dán JD của tin tuyển dụng bạn quan tâm.
3. **Phân tích khoảng cách:** mô hình AI chạy cục bộ đối chiếu hồ sơ với yêu cầu, tính điểm phù hợp và giải thích lý do bằng chữ.
4. **Lập kế hoạch:** ứng dụng chia điểm yếu thành các nhiệm vụ nhỏ 15–30 phút, xếp vào lịch rảnh của bạn.
5. **Theo dõi và điều chỉnh:** làm nhiệm vụ mỗi ngày, cuối tuần xem báo cáo rồi lập lại kế hoạch cho tuần sau.

Toàn bộ quá trình xử lý diễn ra trên máy bạn, không có dữ liệu nào gửi ra dịch vụ bên ngoài.

## Yêu cầu hệ thống

- Cách 1 (khuyến nghị): [Docker](https://docs.docker.com/get-docker/) có Docker Compose v2.
- Cách 2 (không dùng Docker): Python 3.11 trở lên, PostgreSQL 16 và Ollama đã cài.
- RAM: model cỡ 7 tỷ tham số cần khoảng 8 GB RAM trở lên; máy yếu nên chọn model nhỏ hơn (xem mục Cấu hình).
- Ổ đĩa trống: khoảng 10 GB (Docker images và model).

## Cài đặt nhanh bằng Docker

```bash
git clone https://github.com/tql-team/ai-career-coach.git
cd ai-career-coach
cp .env.example .env        # sửa mật khẩu và model nếu cần
make docker-up              # hoặc: docker compose up --build -d
make pull-model             # tải model Ollama lần đầu (vài GB, cần mạng)
```

Mở trình duyệt tại <http://localhost:8000>.

Tài liệu API tự động (Swagger UI): <http://localhost:8000/docs>

Dừng ứng dụng: `make docker-down`.

## Cài đặt không dùng Docker

```bash
git clone https://github.com/tql-team/ai-career-coach.git
cd ai-career-coach
make install                # tạo môi trường ảo .venv và cài thư viện
cp .env.example .env        # sửa DATABASE_URL và OLLAMA_URL cho đúng máy bạn
ollama pull mistral         # hoặc model bạn chọn (phải khớp OLLAMA_MODEL trong .env)
make run
```

Cần PostgreSQL đang chạy và tạo sẵn cơ sở dữ liệu đúng với `DATABASE_URL`.

## Cấu hình

Tất cả đặt trong file `.env` (mẫu ở `.env.example`):

| Biến | Ý nghĩa |
|---|---|
| `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` | Thông tin cơ sở dữ liệu PostgreSQL |
| `DATABASE_URL` | Địa chỉ kết nối khi chạy không dùng Docker |
| `OLLAMA_URL` | Địa chỉ server Ollama |
| `OLLAMA_MODEL` | Tên model Ollama sử dụng (ví dụ `mistral`) |
| `APP_PORT` | Cổng của ứng dụng (mặc định 8000) |

Chọn model: hãy thử vài model với câu tiếng Việt thật trên máy yếu nhất của bạn và **đọc giấy phép của từng model** trên trang model trước khi dùng, vì nhiều model có điều khoản riêng.

## Các lệnh hữu ích

Gõ `make help` để xem đầy đủ.

| Lệnh | Tác dụng |
|---|---|
| `make install` | Tạo môi trường ảo và cài thư viện |
| `make run` | Chạy ứng dụng |
| `make test` | Chạy kiểm thử |
| `make lint` | Kiểm tra định dạng mã |
| `make docker-up` / `make docker-down` | Bật / tắt bằng Docker |
| `make pull-model` | Tải model Ollama |

## Cấu trúc thư mục

```
app/            mã nguồn ứng dụng (FastAPI)
data/           danh mục kỹ năng, vị trí nghề nghiệp, dữ liệu mẫu
docs/           tài liệu cài đặt, kiến trúc, lộ trình phát triển
tests/          kiểm thử
Dockerfile      image cho ứng dụng
docker-compose.yml   chạy ứng dụng, PostgreSQL và Ollama cùng lúc
Makefile        các lệnh thường dùng
```

## Dữ liệu và quyền riêng tư

- Hồ sơ và CV được xử lý trên máy của bạn, không gửi tới dịch vụ bên ngoài.
- Dữ liệu vị trí nghề nghiệp do nhóm tự biên soạn; sinh viên và CV mẫu là dữ liệu giả.
- Kết quả do AI tạo ra chỉ mang tính tham khảo.

## Giấy phép

- **Mã nguồn:** [MIT](LICENSE).
- **Dữ liệu trong `data/`:** [Creative Commons Attribution 4.0 (CC BY 4.0)](data/LICENSE).
- Các thư viện, model và dữ liệu bên thứ ba cùng giấy phép của chúng được liệt kê trong [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md). Model chạy qua Ollama có giấy phép riêng của từng model.

## Đóng góp và liên hệ

Rất hoan nghênh đóng góp, kể cả thêm vị trí nghề nghiệp hay câu hỏi phỏng vấn mới vào thư mục `data/`. Xem hướng dẫn trong [CONTRIBUTING.md](CONTRIBUTING.md).

- Báo lỗi, đề xuất tính năng: <https://github.com/tql-team/ai-career-coach/issues>
- Hỏi đáp, thảo luận: <https://github.com/tql-team/ai-career-coach/discussions>

## Nhóm thực hiện

Đội TQL: Ngọc Thạch, Thục Linh, Tấn Quý.
