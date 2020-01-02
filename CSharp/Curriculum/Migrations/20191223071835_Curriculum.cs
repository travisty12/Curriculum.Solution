using Microsoft.EntityFrameworkCore.Migrations;

namespace Curriculum.Migrations
{
    public partial class Curriculum : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_LessonTrack_Tracks_TrackId",
                table: "LessonTrack");

            migrationBuilder.DropColumn(
                name: "CategoryId",
                table: "LessonTrack");

            migrationBuilder.AlterColumn<int>(
                name: "TrackId",
                table: "LessonTrack",
                nullable: false,
                oldClrType: typeof(int),
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_LessonTrack_Tracks_TrackId",
                table: "LessonTrack",
                column: "TrackId",
                principalTable: "Tracks",
                principalColumn: "TrackId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_LessonTrack_Tracks_TrackId",
                table: "LessonTrack");

            migrationBuilder.AlterColumn<int>(
                name: "TrackId",
                table: "LessonTrack",
                nullable: true,
                oldClrType: typeof(int));

            migrationBuilder.AddColumn<int>(
                name: "CategoryId",
                table: "LessonTrack",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddForeignKey(
                name: "FK_LessonTrack_Tracks_TrackId",
                table: "LessonTrack",
                column: "TrackId",
                principalTable: "Tracks",
                principalColumn: "TrackId",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
